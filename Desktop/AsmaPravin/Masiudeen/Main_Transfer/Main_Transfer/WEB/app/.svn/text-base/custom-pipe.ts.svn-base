import { Pipe, PipeTransform } from '@angular/core';

@Pipe({ name: 'Custom' })
export class CustomPipe implements PipeTransform
{
    // transform(value:string, id:number) :string
    // {
    //     return value + " # Rank " + id.toString();

    // }
    data:any;
    transform(value:any) : any
    {
        if(value == ''){
            this.data = 'N/A';
        }else{
            this.data = value;
        }
        return this.data;
    }
}