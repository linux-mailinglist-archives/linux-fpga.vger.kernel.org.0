Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0E3178DD1
	for <lists+linux-fpga@lfdr.de>; Wed,  4 Mar 2020 10:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgCDJvx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 4 Mar 2020 04:51:53 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2508 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728955AbgCDJvx (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 4 Mar 2020 04:51:53 -0500
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id B0E1580813A97E8700DA;
        Wed,  4 Mar 2020 09:51:51 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML712-CAH.china.huawei.com (10.201.108.35) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 4 Mar 2020 09:51:51 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 4 Mar 2020
 09:51:50 +0000
Subject: Re: LPC Bus Driver
To:     Luis Tanica <luis.f.tanica@seagate.com>,
        Arnd Bergmann <arnd@arndb.de>, "Xu Yilun" <yilun.xu@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>
References: <6daf1bb266a24c239aed34d8661fc5eaMW2PR20MB210660F6B17CB90ACD0B6E7CA0E70@MW2PR20MB2106.namprd20.prod.outlook.com>
 <797cec65-5504-ee85-3fe4-fe2b4c90991f@huawei.com>
 <20200303154522.GA24568@yilunxu-OptiPlex-7050>
 <CAK8P3a01vYfqvj4eRQQsqC9FrUTr=q6ZRF-EuYV0iGC7AV7UBQ@mail.gmail.com>
 <3992844da4534804ade896dd5ba4dfcbMW2PR20MB2106669451CA09B579ECB973A0E40@MW2PR20MB2106.namprd20.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <8e410a65-5e48-7c25-d3e5-319dec12858f@huawei.com>
Date:   Wed, 4 Mar 2020 09:51:49 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <3992844da4534804ade896dd5ba4dfcbMW2PR20MB2106669451CA09B579ECB973A0E40@MW2PR20MB2106.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 03/03/2020 18:07, Luis Tanica wrote:
> Thank you all for the help. This is the gist of what I got from your responses.
> 
>   - if CPLD is the only thing on LPC bus, consider creating a single driver for it
>   - if not, then creating the LPC bus layer would be ideal
>   - could also consider I2C framework and treat it like an I2C device
> 
> I believe for us we'll only ever have that one CPLD on the LPC bus, so a single driver could be a good idea.
> The only reason I like regmap though, is that I could define a regmap bus that would implement all the LPC read/write operations (by implementing the .reg_read and .reg_write for regmap_bus) nd then I could use those registers as I pleased from different places.
> For instance, we could have a CPLD driver that exposes all the registers/fields via sysfs but then I could also have an arm-reset driver that only maps the register it needs for the arm reset.
> 
> I actually started implementing the LPC bus, and then having 2 devices (reset and cpld) implemented as LPC devices.
> Even though it seems a bit more logical overall, it's a lot of overhead for what I need.
> 
> I would like to take a look at the I2C option, since that's the only idea here I haven't explored. If you could point me in the right direction on how to do it (or some examples in the kernel) I'd appreciate.

Arnd originally gave me this idea for modelling the HiSilicon LPC driver 
as an I2C host, so he may know.

 From checking drivers/i2c/busses/Kconfig, maybe I2C_CROS_EC_TUNNEL 
could support LPC.

> I should be able to make a decision after that, but I'm tempted to create a single driver and keep it simple for now.
> 
> P.S.: This is my first time using the mailing list and I'm guessing Outlook is not the best client to use. Any tips on that end?

Maybe this will help:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/email-clients.rst

I use firefox in windows, since outlook cannot be configured for kernel 
posting style, AFAIK.

> 
>     Luis
> 
> 
> 
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Sent: Tuesday, March 3, 2020 09:24
> 
> To: Xu Yilun <yilun.xu@intel.com>
> 
> Cc: John Garry <john.garry@huawei.com>; Luis Tanica <luis.f.tanica@seagate.com>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-fpga@vger.kernel.org <linux-fpga@vger.kernel.org>; gregkh <gregkh@linuxfoundation.org>
> 
> Subject: Re: LPC Bus Driver
> 
>   
> 
> 
> On Tue, Mar 3, 2020 at 4:47 PM Xu Yilun <yilun.xu@intel.com> wrote:
> 
>> On Tue, Mar 03, 2020 at 10:13:36AM +0000, John Garry wrote:
> 
>>> + add fpga list and Greg+Arnd for misc drivers
> 
>>>> We have this board with our own SoC, which is connected to an external CPLD (FPGA) via LPC (low pin count) bus.
> 
>>>> I've been doing some research to see what the best way of designing the drivers for it would be, and came across the Hisilicon LPC driver stuff (which I believe you're the maintainer for).
> 
>>>>
> 
>>>> Just a little background. Let's say our host (ARM) has a custom LPC controller. The LPC controller let's us perform reads/writes of CPLD registers via LPC bus. This CPLD is the only slave device attached to that bus and we only use it for reading/writing
>   certain
> 
>>>>    registers (e.g., we use it to access some system information and for resetting the ARM during reboot).
> 
>>>>
> 
>>>> I was looking at the regmap framework and that seemed a good way to go.
> 
>>>
> 
>>> I thought that regmap only allows mapping in MMIO regions for multiplexing
> 
>>> access from multiple drivers or accessing registers outside the device HW
> 
>>> registers, but you seem to need to manually generate the LPC bus accesses to
> 
>>> access registers on the slave device.
> 
>>
> 
>> I'm not familar with LPC controller, but seems it could not perform
> 
>> read/write by one memory access or io access instruction
> 
>>
> 
>> I didn't find an existing bus_type for LPC bus, so I think regmap is a
> 
>> good way. When you have implemented the regmap for LPC bus, you need to
> 
>> access the CPLD registers by regmap_read/write, and just pass CPLD local
> 
>> register addr as parameter.
> 
> 
> 
> LPC uses the same software abstraction as the old ISA bus, providing
> 
> port (inb/outb) and mmio (readl/writel) style register access as well as
> 
> interrupts and a crude form of DMA access.
> 
> 
> 
> Whether regmap or something else works depends on which of these
> 
> communication options the CPLD uses.
> 
> 
> 
>>> If this FPGA is the only device which will ever be on this LPC bus, then
> 
>>> could you encode the LPC accesses directly in the FPGA driver?
> 
> 
> 
> I think this is the most important question. If the same SoC is used
> 
> in systems that connect something else on the same LPC bus, then
> 
> making it look like a normal ISA/LPC bus to Linux is probably best,
> 
> but if the CPLD and SoC are only ever used in this one combination,
> 
> there is nothing wrong with pretending that the LPC MMIO interface
> 
> on this chip part of the driver for the CPLD.
> 
> 
> 
>>> As another alternative, it might be worth considering writing an I2C
> 
>>> controller driver for your LPC host, i.e. model as an I2C bus, and have an
> 
>>> I2C client driver for the LPC slave (FPGA). I think that there are examples
> 
>>> of this in the kernel.
> 
>>
> 
>> How the host cpu is connected to LPC host?
> 
>> Why an I2C controller driver for LPC host? The LPC bus is compatible to i2c bus?
> 
> 
> 
> i2c is a simple bus that allows multiple devices to share a bus
> 
> and perform read/write operations on numbered registers. If the device
> 
> attached to the LPC bus fits into that, it might be even easier than
> 
> regmap.
> 
> 
> 
>         Arnd
> 
> .
> 

