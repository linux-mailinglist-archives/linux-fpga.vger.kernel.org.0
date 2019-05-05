Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 582FD13E72
	for <lists+linux-fpga@lfdr.de>; Sun,  5 May 2019 10:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfEEIkk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 5 May 2019 04:40:40 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:39166 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfEEIkk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 5 May 2019 04:40:40 -0400
Received: by mail-wm1-f42.google.com with SMTP id n25so11455710wmk.4
        for <linux-fpga@vger.kernel.org>; Sun, 05 May 2019 01:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yKCOTDQOXUsSPAME2lkXIJpmj87HyoGf++bvVNmxMvQ=;
        b=ROhZxZZZWUPTpjdGNV/YM3v2spwhKZkTCo4HBBSuuHscQDuaWXqDchQ8K+cNka/KJw
         +2TRrajwZ66ZPhH2mSYcM+/QWnxw2lJsCiyOK8I7GiCO8NziXjWlNUHqScEv03zdRVP7
         UfeOX+9l7vbt90YO98mnkxsC9z90XpA9/7W4XPYod5BP+zVaq5p4fxpwp2M8nvbe4YZK
         drURyxjQD9qxzM0t4GEMOl7rH1Uy6mvumNAK/3YyAACZ8ho2kXHHx3qVn/CmzBgXMPUA
         dZVP/f9q0UySPQChDdEYi6GPb+076i7gmYVjUMmz7JDaTShfYMaGWuXYpepvsvL+G7Hx
         54eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yKCOTDQOXUsSPAME2lkXIJpmj87HyoGf++bvVNmxMvQ=;
        b=Z5wWxfhEimQqsSrzHQouvwGhEue/t6bPya/rRsvZuYwMyot9tgV/STbbW5JoVAuETH
         5ebKHHHxmRgkGw0zVmhe6qNFAOo6l03P9gaxdqbNukaDaL0baDhaKoN/7QK0NOK0lrrn
         jdT2Ke15waJj9SnKUjNna2VMVpleAL+p6+rWYejnxXgNca2IzkUY4oAuQyCq7kIc/QjO
         nqLdJ6ly2IaIK2ydg+r8psPTxFh+9cQHjsR3XmU9oVxVyrjgGStVLVOiHEa+URhfGkVG
         zP72COYG9vAHhkEnTGkSL2bv7vFbcFyIFqgNAQ7ok0WbNU2UP51ZFW5KbK87kQeAzHqg
         /R7w==
X-Gm-Message-State: APjAAAWVG3DEl/hWvXakSFpGFWUiNpooTRYyomQBLaC8RleIzzeEWTrY
        1yBk3oM3B4UrsgR0W5jZ1fMeZudn
X-Google-Smtp-Source: APXvYqywsmOkVM6RM/2rVoQmQ9Cq+daTvTY1YrXUfdH9HNPyNbGZLJY4SBRLG+l/s+J9rgDOtDUZCw==
X-Received: by 2002:a1c:2986:: with SMTP id p128mr12529294wmp.134.1557045638488;
        Sun, 05 May 2019 01:40:38 -0700 (PDT)
Received: from [192.168.0.18] ([94.54.58.88])
        by smtp.gmail.com with ESMTPSA id y197sm6438803wmd.34.2019.05.05.01.40.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 01:40:37 -0700 (PDT)
Subject: Re: FPGA Manager - Partial Reconfiguration support for Xilinx
 Zynq-7000
To:     Michal Simek <michal.simek@xilinx.com>, linux-fpga@vger.kernel.org,
        Nava kishore Manne <navam@xilinx.com>
Cc:     Ronan Keryell <rkeryell@xilinx.com>
References: <5bdf4d79-c0d6-30c1-1eb0-360b7dce615b@gmail.com>
 <70789e51-cb23-9776-dafe-fb34a0736bad@xilinx.com>
From:   Alper Yazar <alperyazar2@gmail.com>
Message-ID: <25125fd1-639b-69c3-f381-dfbfcee31c02@gmail.com>
Date:   Sun, 5 May 2019 11:40:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <70789e51-cb23-9776-dafe-fb34a0736bad@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 3/7/19 2:06 PM, Michal Simek wrote:
> Hi,
> 
> On 03. 03. 19 12:32, Alper Yazar wrote:
>> Hi,
>>
>> I asked the question on Xilinx forums about 1 months ago but didn't get any response [1]. I hope that someone on this list may guide me.
>>
>> I am creating Linux based images for Zynq-7000 devices by using Petalinux 2018.3 which is a set of build tools provided by Xilinx. For FPGA management, FPGA Manager is included by default. However it doesn't support partial reconfiguration for Zynq-7000 devices as stated [2]. I tested and verified that it doesn't work. I assumed that /drivers/fpga/zynq-fpga.c is the source code, checked it and noticed some comments about partial reconfig. AFAIK previous driver used by Xilinx before FPGA Manager whose source code file is xilinx_devcfg.c supported partial reconfig. So I don't think that there is a hardware limitation since the previous solution was working on the same device. So I wonder why the newest method is less capable than the older one. I need partial reconfig support for the newest petalinux version. What should I do?
>>
>> a) Compile old xilinx_devcfg.c driver for Petalinux 2018.3 and disable FPGA Manager. 
>>
>> b) Somehow patch FPGA Manager
>>
>> c) Wait (how long?) Xilinx to solve this issue
>>
>> Two names are listed as MODULE_AUTHOR of zynq-fpga.c: Moritz Fischer and Michal Simek. I don't know whether they are subscribed to this list or not.
>>
>>
>> [1]: https://forums.xilinx.com/t5/Embedded-Linux/Partial-Reconfiguration-support-in-Petalinux-2018-3-for-Zynq/td-p/934057
>> [2]: https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18841645/Solution+Zynq+PL+Programming+With+FPGA+Manager
> 
> Nava: Can you please check if partial reconfiguration is still working?
> I see code in the driver.
> 
> Alper: Can you please use u-boot and check that your bitstreams are
> correct?
> Also will be good to have some logs to see what it is happening.
> 
> Thanks,
> Michal
> 

Hi Michal,

Sorry for late response. We checked U-boot and it worked without any problem. Our bitstreams are based on the Xilinx example project on partial reconfiguration.

1. Loading full bitstream using U-boot (successful):

Zynq> fatload mmc 0 0x4000000 top.bit

reading top.bit

4045663 bytes read in 235 ms (16.4 MiB/s)

Zynq> fpga loadb 0 0x4000000 4045663

  design filename = "top;UserID=0XFFFFFFFF;Version=2018.3"

  part number = "7z020clg484"

  date = "2019/01/30"

  time = "00:54:18"

  bytes in bitstream = 4045564

zynq_align_dma_buffer: Align buffer at 4000063 to 3ffff80(swap 1)


2. Loading partial bitstream using U-boot (successful):

Zynq> fatload mmc 0 0x4000000 S_knight_top_partial.bit

reading S_knight_top_partial.bit

1238420 bytes read in 81 ms (14.6 MiB/s)

Zynq> fpga loadbp 0 0x4000000 1238420

  design filename = "top;UserID=0XFFFFFFFF;PARTIAL=TRUE;Version=2018.3"

  part number = "7z020clg484"

  date = "2019/01/30"

  time = "00:54:40"

  bytes in bitstream = 1238308

zynq_align_dma_buffer: Align buffer at 4000070 to 3ffff80(swap 1)

Both of them worked fine.


3. Loading full bitstream on Petalinux 2018.3 (successful):

root@project4:~# mkdir -p /lib/firmware

root@project4:~# cd /mnt

root@project4:/mnt# cp top.bit.bin /lib/firmware

root@project4:/mnt# echo top.bit.bin >/sys/class/fpga_manager/fpga0/firmware

fpga_manager fpga0: writing top.bit.bin to Xilinx Zynq FPGA Manager


4. Loading partial bitstream on Petalinux 2018.3 (NOT successful):

root@project4:/mnt# cp S_knight_top_partial.bit.bin /lib/firmware

root@project4:/mnt# echo S_knight_top_partial.bit.bin >/sys/class/fpga_manager/fpga0/firmware

fpga_manager fpga0: writing S_knight_top_partial.bit.bin to Xilinx Zynq FPGA Manager

--- Wait few seconds ---

fpga_manager fpga0: Error after writing image data to FPGA

-sh: echo: write error: Connection timed out

We also checked fpga-mgr.h and saw the definiton: "#define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)". For partial bitstream trials we also tried setting this bit to 1 by "echo 1 > /sys/class/fpga_manager/fpga0/flags" command but this didn't affect the result.

Since FPGA manager uses BIN file we convert BIT to BIN using SDK. U-boot works with BIT files. Is it possible that this conversion cause the problem? How should we convert BIT to BIN file?

Best,

Alper

