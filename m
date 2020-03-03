Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17DE9177396
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Mar 2020 11:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgCCKNk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Mar 2020 05:13:40 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2501 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728102AbgCCKNk (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 3 Mar 2020 05:13:40 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 1BD9D9119670BA0EB938;
        Tue,  3 Mar 2020 10:13:38 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML714-CAH.china.huawei.com (10.201.108.37) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 3 Mar 2020 10:13:37 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 3 Mar 2020
 10:13:37 +0000
Subject: Re: LPC Bus Driver
To:     Luis Tanica <luis.f.tanica@seagate.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-fpga@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <6daf1bb266a24c239aed34d8661fc5eaMW2PR20MB210660F6B17CB90ACD0B6E7CA0E70@MW2PR20MB2106.namprd20.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <797cec65-5504-ee85-3fe4-fe2b4c90991f@huawei.com>
Date:   Tue, 3 Mar 2020 10:13:36 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <6daf1bb266a24c239aed34d8661fc5eaMW2PR20MB210660F6B17CB90ACD0B6E7CA0E70@MW2PR20MB2106.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

+ add fpga list and Greg+Arnd for misc drivers

Hi Luis,

> 
> We have this board with our own SoC, which is connected to an external CPLD (FPGA) via LPC (low pin count) bus.
> I've been doing some research to see what the best way of designing the drivers for it would be, and came across the Hisilicon LPC driver stuff (which I believe you're the maintainer for).
> 
> Just a little background. Let's say our host (ARM) has a custom LPC controller. The LPC controller let's us perform reads/writes of CPLD registers via LPC bus. This CPLD is the only slave device attached to that bus and we only use it for reading/writing certain
>   registers (e.g., we use it to access some system information and for resetting the ARM during reboot).
> 
> I was looking at the regmap framework and that seemed a good way to go. 

I thought that regmap only allows mapping in MMIO regions for 
multiplexing access from multiple drivers or accessing registers outside 
the device HW registers, but you seem to need to manually generate the 
LPC bus accesses to access registers on the slave device.

If this FPGA is the only device which will ever be on this LPC bus, then 
could you encode the LPC accesses directly in the FPGA driver?

 > But then I saw the logic_pio stuff as well and now I'm not sure what 
the best approach would be anymore

Logic PIO is for IO Port accesses. It could serve your purpose, but you 
would need to use IO port accesses for your slave driver, like inb and outb.

As another alternative, it might be worth considering writing an I2C 
controller driver for your LPC host, i.e. model as an I2C bus, and have 
an I2C client driver for the LPC slave (FPGA). I think that there are 
examples of this in the kernel.

All the best,
john
