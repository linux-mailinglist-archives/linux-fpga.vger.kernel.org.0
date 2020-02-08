Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D36EF156548
	for <lists+linux-fpga@lfdr.de>; Sat,  8 Feb 2020 16:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgBHP6u (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 8 Feb 2020 10:58:50 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:37269 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgBHP6t (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 8 Feb 2020 10:58:49 -0500
Received: by mail-pf1-f175.google.com with SMTP id p14so1373435pfn.4
        for <linux-fpga@vger.kernel.org>; Sat, 08 Feb 2020 07:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=kHB03wJri0b3MKm5lFCZoZW600STJa6MKzzC4scLUbs=;
        b=InqKlP7GxJn3WwXXcsOSTC4xqbj3uDHDpXUpLkYsDes0Y4XXPGvgdn2fcIT5r4HES3
         cYjHK99bT4mA9ioDqlrPGP7fOQL0Utn238cRNZRAdIF0Sngsg86qWsiQ+cwdu4sInh1g
         8vyD4F5gWE9trZW48CsKWl9pIqr/iHL05cp9/SLIiutXGS6yrYMFcligTgVXfejMrMw1
         Q32+tsy+EOW9p5Cs3nmidhEJsyrK8+VRVpoaSGWDFxHzd+FbKWUFsb9wV7RtoQ05tyOw
         o10W6zxICwT0LA7cKew1ypzN74HWXcqkefKTXvJ/sEzdnn/e0urect5RvkswDDcw0liF
         cqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kHB03wJri0b3MKm5lFCZoZW600STJa6MKzzC4scLUbs=;
        b=HfgsjdPtCQ38EJzU8NnGi12TUHr5XF6DXjfNcPXRAUEOsQisvooGo9//iJr32XWe4Y
         83/MKrHA6XjoLYjMl5OOCcbEaqmoDgdxHCFCYbX/eAkvl3QzSiR+a3c7+nzaGYWkor0b
         5AIx3WdtMiJdf3c5jsVf5ANZRqYlLaT6EkVLJgW+1RycC01NdLcfgOHze/jIDsjkl1Ie
         DZfAawHIbSHlfjZMyWdojIxqb6ycOgd9iGGSSOiCvMINN4SRUxfnLBA5rMqgifbgr4BV
         OH3GB3qCFU+XdHrNCi05krWH2tfiTPpIFGLrDhLOnHGzFOBSurIbJZShOzuItT84etZE
         QjsQ==
X-Gm-Message-State: APjAAAX+2q6BZh6aJAokIva5qegi5qzwgOCt6oUer20G/ks0L9rt68s6
        vo2oSWqqXlHscOXYB1/kJETTfy0JMR4=
X-Google-Smtp-Source: APXvYqyHbjAm98hlylfmAmHCx/hUstg/emyxZvNccTjmOOSIO2xx/AWvBjFYKVvookNQzHuAqkzFnA==
X-Received: by 2002:a63:aa07:: with SMTP id e7mr5305250pgf.90.1581177529098;
        Sat, 08 Feb 2020 07:58:49 -0800 (PST)
Received: from [192.168.0.18] ([176.240.52.116])
        by smtp.gmail.com with ESMTPSA id a27sm7122064pfr.162.2020.02.08.07.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2020 07:58:48 -0800 (PST)
Subject: Re: FPGA Manager - Partial Reconfiguration support for Xilinx
 Zynq-7000
To:     Nava kishore Manne <navam@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Cc:     Ronan Keryell <rkeryell@xilinx.com>
References: <5bdf4d79-c0d6-30c1-1eb0-360b7dce615b@gmail.com>
 <70789e51-cb23-9776-dafe-fb34a0736bad@xilinx.com>
 <25125fd1-639b-69c3-f381-dfbfcee31c02@gmail.com>
 <MN2PR02MB62240EE694CB567FC3F7D46DC2300@MN2PR02MB6224.namprd02.prod.outlook.com>
From:   Alper Yazar <alperyazar2@gmail.com>
Message-ID: <7991f0f9-138a-eb7c-d453-cb1adc1d2a5f@gmail.com>
Date:   Sat, 8 Feb 2020 18:58:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <MN2PR02MB62240EE694CB567FC3F7D46DC2300@MN2PR02MB6224.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi again,

It looks like partial reconfiguration for Zynq-7000 working since 
Petalinux 2019.1.

Best,

Alper

> Hi Alper Yazar,
>
> Please look at the below wiki link to generate .bin form .bit file.
> https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18841645/Solution+Zynq+PL+Programming+With+FPGA+Manager#SolutionZynqPLProgrammingWithFPGAManager-Generating.binfrom.bitfileusingBootgen
>
> Regards,
> Navakishore.
>
>> -----Original Message-----
>> From: Alper Yazar [mailto:alperyazar2@gmail.com]
>> Sent: Sunday, May 5, 2019 2:11 PM
>> To: Michal Simek <michals@xilinx.com>; linux-fpga@vger.kernel.org; Nava
>> kishore Manne <navam@xilinx.com>
>> Cc: Ronan Keryell <rkeryell@xilinx.com>
>> Subject: Re: FPGA Manager - Partial Reconfiguration support for Xilinx Zynq-
>> 7000
>>
>> On 3/7/19 2:06 PM, Michal Simek wrote:
>>> Hi,
>>>
>>> On 03. 03. 19 12:32, Alper Yazar wrote:
>>>> Hi,
>>>>
>>>> I asked the question on Xilinx forums about 1 months ago but didn't get any
>> response [1]. I hope that someone on this list may guide me.
>>>> I am creating Linux based images for Zynq-7000 devices by using Petalinux
>> 2018.3 which is a set of build tools provided by Xilinx. For FPGA management,
>> FPGA Manager is included by default. However it doesn't support partial
>> reconfiguration for Zynq-7000 devices as stated [2]. I tested and verified that it
>> doesn't work. I assumed that /drivers/fpga/zynq-fpga.c is the source code,
>> checked it and noticed some comments about partial reconfig. AFAIK previous
>> driver used by Xilinx before FPGA Manager whose source code file is
>> xilinx_devcfg.c supported partial reconfig. So I don't think that there is a
>> hardware limitation since the previous solution was working on the same device.
>> So I wonder why the newest method is less capable than the older one. I need
>> partial reconfig support for the newest petalinux version. What should I do?
>>>> a) Compile old xilinx_devcfg.c driver for Petalinux 2018.3 and disable FPGA
>> Manager.
>>>> b) Somehow patch FPGA Manager
>>>>
>>>> c) Wait (how long?) Xilinx to solve this issue
>>>>
>>>> Two names are listed as MODULE_AUTHOR of zynq-fpga.c: Moritz Fischer
>> and Michal Simek. I don't know whether they are subscribed to this list or not.
>>>>
>>>> [1]:
>>>> https://forums.xilinx.com/t5/Embedded-Linux/Partial-Reconfiguration-s
>>>> upport-in-Petalinux-2018-3-for-Zynq/td-p/934057
>>>> [2]:
>>>> https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18841645/Soluti
>>>> on+Zynq+PL+Programming+With+FPGA+Manager
>>> Nava: Can you please check if partial reconfiguration is still working?
>>> I see code in the driver.
>>>
>>> Alper: Can you please use u-boot and check that your bitstreams are
>>> correct?
>>> Also will be good to have some logs to see what it is happening.
>>>
>>> Thanks,
>>> Michal
>>>
>> Hi Michal,
>>
>> Sorry for late response. We checked U-boot and it worked without any problem.
>> Our bitstreams are based on the Xilinx example project on partial
>> reconfiguration.
>>
>> 1. Loading full bitstream using U-boot (successful):
>>
>> Zynq> fatload mmc 0 0x4000000 top.bit
>>
>> reading top.bit
>>
>> 4045663 bytes read in 235 ms (16.4 MiB/s)
>>
>> Zynq> fpga loadb 0 0x4000000 4045663
>>
>>    design filename = "top;UserID=0XFFFFFFFF;Version=2018.3"
>>
>>    part number = "7z020clg484"
>>
>>    date = "2019/01/30"
>>
>>    time = "00:54:18"
>>
>>    bytes in bitstream = 4045564
>>
>> zynq_align_dma_buffer: Align buffer at 4000063 to 3ffff80(swap 1)
>>
>>
>> 2. Loading partial bitstream using U-boot (successful):
>>
>> Zynq> fatload mmc 0 0x4000000 S_knight_top_partial.bit
>>
>> reading S_knight_top_partial.bit
>>
>> 1238420 bytes read in 81 ms (14.6 MiB/s)
>>
>> Zynq> fpga loadbp 0 0x4000000 1238420
>>
>>    design filename = "top;UserID=0XFFFFFFFF;PARTIAL=TRUE;Version=2018.3"
>>
>>    part number = "7z020clg484"
>>
>>    date = "2019/01/30"
>>
>>    time = "00:54:40"
>>
>>    bytes in bitstream = 1238308
>>
>> zynq_align_dma_buffer: Align buffer at 4000070 to 3ffff80(swap 1)
>>
>> Both of them worked fine.
>>
>>
>> 3. Loading full bitstream on Petalinux 2018.3 (successful):
>>
>> root@project4:~# mkdir -p /lib/firmware
>>
>> root@project4:~# cd /mnt
>>
>> root@project4:/mnt# cp top.bit.bin /lib/firmware
>>
>> root@project4:/mnt# echo top.bit.bin
>>> /sys/class/fpga_manager/fpga0/firmware
>> fpga_manager fpga0: writing top.bit.bin to Xilinx Zynq FPGA Manager
>>
>>
>> 4. Loading partial bitstream on Petalinux 2018.3 (NOT successful):
>>
>> root@project4:/mnt# cp S_knight_top_partial.bit.bin /lib/firmware
>>
>> root@project4:/mnt# echo S_knight_top_partial.bit.bin
>>> /sys/class/fpga_manager/fpga0/firmware
>> fpga_manager fpga0: writing S_knight_top_partial.bit.bin to Xilinx Zynq FPGA
>> Manager
>>
>> --- Wait few seconds ---
>>
>> fpga_manager fpga0: Error after writing image data to FPGA
>>
>> -sh: echo: write error: Connection timed out
>>
>> We also checked fpga-mgr.h and saw the definiton: "#define
>> FPGA_MGR_PARTIAL_RECONFIG	BIT(0)". For partial bitstream trials we
>> also tried setting this bit to 1 by "echo 1 >
>> /sys/class/fpga_manager/fpga0/flags" command but this didn't affect the
>> result.
>>
>> Since FPGA manager uses BIN file we convert BIT to BIN using SDK. U-boot
>> works with BIT files. Is it possible that this conversion cause the problem? How
>> should we convert BIT to BIN file?
>>
>> Best,
>>
>> Alper
