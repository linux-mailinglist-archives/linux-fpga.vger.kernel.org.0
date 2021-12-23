Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46E247E90A
	for <lists+linux-fpga@lfdr.de>; Thu, 23 Dec 2021 22:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350341AbhLWVXo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 23 Dec 2021 16:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350340AbhLWVXm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 23 Dec 2021 16:23:42 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62DFC061401
        for <linux-fpga@vger.kernel.org>; Thu, 23 Dec 2021 13:23:40 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t26so13816952wrb.4
        for <linux-fpga@vger.kernel.org>; Thu, 23 Dec 2021 13:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastree3d-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=0lNDi24rHv40AIxYnxEYbC4KJlxmLKcCCZq1U8FdpZk=;
        b=g+qJ8KYww8cprY01SIGgkw0zYpG6gFBWNV7FNSwpcSvXHg5N0LdJ0Uv/665ydqOurq
         So659PvjWNEmsqvIJkC6JmvrVbZkk2g3QPYcPYTC9TlEpzHfq+p3ejs/iT2ODKDd5BfE
         fu7ZnLnopxziOQodDbJVhB1wdAC7xWLP6RwLFVw4bm9FN2imH78zbihLcUAhVKkfAw8B
         akjz1fMD1/Q6QpIgkJMQyfDEODpk5z/vcqAsPCbSbwwx0P54A665nL/YWzzVPbsVi3fJ
         8RuExDa143BKoQJvGyKqSTmVn1CBTgZwambwgtuievLCHjT/Knn97pO80BKDu/4JQWQJ
         g04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=0lNDi24rHv40AIxYnxEYbC4KJlxmLKcCCZq1U8FdpZk=;
        b=COX3dY+XvaVcyKQp/YugvrKG3XWKpbcNrlsnBA+00eQoKDHAtq+C91w2ehxwhcVP7w
         7Zh93i7e7rnzDTbBQJZ5ozITK556IgRismliVsqQXlm9ExuDoYG8islY1FhepWcJy7Y0
         FBJSjZiEyW1dewWn0OkiOQ1KetrxHPrfqJoLV7a/a9VX+c/7QDFg/YzU7h8X1CE9D0wQ
         5/ZVsvmiLqP2bI4ClKI+DLumOx8ju3AInURmtpEecAVEsyhgK14GQeLzgJxuQshHQsRy
         WcOfpFzrBcV3WOmjpo/Ye4lsavkUoZD5KoK6ENeY/4HgNkcrMUQ4i7tK0eeoxG+gFtYJ
         S9Wg==
X-Gm-Message-State: AOAM530+fdxiL32l3/mDd8QOv9c/K4CarDhjQrmJVOF5dhy0QYXyRVqw
        WkyjeSH9HEid6EpEh1sFM59xi8AcUviyr3QT
X-Google-Smtp-Source: ABdhPJwNVL9HlZHIVQZhpbQTgV9iYULVAzYpqSukymhhN93viaIgNX5H1S+GBwrudIpkbsqLMOyOBg==
X-Received: by 2002:a5d:554e:: with SMTP id g14mr2798302wrw.353.1640294619138;
        Thu, 23 Dec 2021 13:23:39 -0800 (PST)
Received: from dls5-laptop.home ([2a01:cb10:16d:b800:445d:3d24:e01f:e7c0])
        by smtp.gmail.com with ESMTPSA id a198sm5849232wmd.42.2021.12.23.13.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 13:23:38 -0800 (PST)
Message-ID: <6689f32777df260c90999957d566f6715a04fe2f.camel@fastree3d.com>
Subject: Re: Partial reconfiguration on ZynqMP
From:   Simon Doppler <simon.doppler@fastree3d.com>
To:     Nava kishore Manne <navam@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Cc:     "adrian.fiergolski@fastree3d.com" <adrian.fiergolski@fastree3d.com>
Date:   Thu, 23 Dec 2021 22:23:37 +0100
In-Reply-To: <SN6PR02MB4576F9F6F7710989F8EDAE16C27E9@SN6PR02MB4576.namprd02.prod.outlook.com>
References: <23cf0454cadc24bc0fd7d898ab3d4bd4dfd95bac.camel@fastree3d.com>
         <BYAPR02MB3925AB4E544B1E93232A4BB2D97D9@BYAPR02MB3925.namprd02.prod.outlook.com>
         <SN6PR02MB4576F9F6F7710989F8EDAE16C27E9@SN6PR02MB4576.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi,

See my reply below.

On Thu, 2021-12-23 at 06:03 +0000, Nava kishore Manne wrote:
> Hi ,
> 	Please find my response inline.
> 
> > > -----Original Message-----
> > > From: Simon Doppler <simon.doppler@fastree3d.com>
> > > Sent: Wednesday, December 22, 2021 2:14 PM
> > > To: mdf@kernel.org; trix@redhat.com; Michal Simek
> > > <michals@xilinx.com>; linux-fpga@vger.kernel.org
> > > Cc: Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
> > > Subject: Partial reconfiguration on ZynqMP
> > > 
> > > Hi everyone,
> > > 
> > > We are currently trying to use partial reconfiguration for our
> > > ZynqMP-
> > > based system (part is xczu6eg) and device-tree overlay based
> > > reconfiguration crashes.
> > > Our Linux system is using 5.10.0-xilinx-v2021.1.
> > > 
> > > The reconfigurable partition is decoupled from the rest of the
> > > design
> > > with an AXI-shutdown manager IP and a DFX decoupler (the
> > > shutdown_requested signal of the AXI shutdown manager is used to
> > > drive
> > > the request_shutdown of the DFX decoupler).
> > > 
> > > The relevant parts of the device tree are:
> > > 
> > > ---- BEGIN SNIP ----
> > > fpga_full: fpga-full {
> > > 		status = "okay";
> > > 		reconf_region: reconf_region0 {
> > > 			  compatible = "fpga-region";
> > > 			  fpga-bridges = <&reconf_bridge0>;
> > > 		};
> > >        };
> > > 
> > > reconf_bridge0: reconf_bridge@a0080000  {
> > > 			status = "okay";
> > > 			compatible = "xlnx,dfx-axi-shutdown-manager-
> > 1.00";
> > > 			reg = <0x0 0xa0080000 0x0 0x10>;
> > > 			clock-names = "aclk";
> > > 			clocks = <&zynqmp_clk 73>;
> > > 			bridge-enable = <1>;
> > > 		};
> > > ---- END SNIP ----
> > > 
> > > To reconfigure, I tested the following cases:
> > > 
> > > 1. manual reconfiguration: WORKS
> > >    - decouple by writing to the register directly
> > >    - reconfigure directly with the fpga-manager
> > >    - recouple by writing directly to the register
> > > 
> > > 2. full reconfiguration with device-tree overlay: WORKS
> > >    - we feed the full bitstream to the FPGA manager
> > >    - using the following device-tree overlay:
> > > ---- BEGIN SNIP ----
> > > /dts-v1/;
> > > /plugin/;
> > > 
> > > &reconf_region {
> > > 	firmware-name = "full.bit";
> > > };
> > > ---- BEGIN SNIP ----
> > > 
> > > 3. partial reconfiguration with device-tree overlay:
> > >    - we feed the full bitstream to the FPGA manager
> > >    - using the following device-tree overlay:
> > > ---- BEGIN SNIP ----
> > > /dts-v1/;
> > > /plugin/;
> > > 
> > > &reconf_region {
> > > 	partial-fpga-config;
> > > 	fpga-bridges = <&reconf_bridge0>;
> > > 	firmware-name = "partial.bit";
> > > };
> > > ---- BEGIN SNIP ----
> > > 
> > > In this case, the whole system crashes (even the platform cable
> > > does
> > > not respond anymore).
> > > When setting an ILA trigger on the write valid signal of the AXI
> > > control path of the AXI Shutdown manager, the ILA appears to
> > > trigger
> > > but crashes before the data is shown in the hardware manager
> > > window of
> > Vivado.
> > > When the partial bitstream written by the overlay is already
> > > loaded
> > > (by hand, as is case 1), the reconfiguration using an overlay
> > > works
> > > and the AXI Shutdown manager is written to as expected.
> > > 
> > > Do you have an idea on what is going wrong here ?
> > > As I manage to do the reconfiguration by hand, I suspect a
> > > configuration/device-tree/software error.
> > > 
> 
> In the case 2 use case could you please provide more details (if
> possible please share the log)
> needs to cross verify whether the axi shutdown manager is
> written/configured as expected.
> 

In case 2, the bridge is not triggered as I replace the full bitstream
including the bridge. The relevant parts of the log are below:

U-Boot SPL 2021.01 (Oct 12 2021 - 09:28:42 +0000)
[....]
U-Boot 2021.01 (Oct 12 2021 - 09:28:42 +0000)
[....]
Scanning mmc 1:1...
Found U-Boot script /boot.scr
509 bytes read in 6 ms (82 KiB/s)
## Executing script at 20000000
26510890 bytes read in 1759 ms (14.4 MiB/s)
  design filename = "Falcon;UserID=0XFFFFFFFF;Version=2021.1"
  part number = "xczu6eg-ffvc900-1-i"
  date = "2021/12/20"
  time = "16:29:50"
  bytes in bitstream = 26510780
zynqmp_align_dma_buffer: Align buffer at 000000000010006e to
00000000000fff80(swap 0)
49559 bytes read in 16 ms (3 MiB/s)
21019136 bytes read in 1393 ms (14.4 MiB/s)
## Flattened Device Tree blob at 00100000
   Booting using the fdt blob at 0x100000
   Loading Device Tree to 000000007de03000, end 000000007de12196 ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 5.10.0-xilinx-v2021.1 (oe-user@oe-host)
(aarch64-poky-linux-gcc (GCC) 10.2.0, GNU ld (GNU Binutils)
2.36.1.20210209) #1 SMP Tue Oct 12 09:30:57 UTC 2021
[....]
[    0.000000] Kernel command line: video=DP-1:1920x1080 xilinx-
video.is_mplane=0 root=/dev/mmcblk1p2 rw rootwait earlycon
clk_ignore_unused
[....]
[    3.217384] zynqmp-ipi-mbox mailbox@ff990400: Registered ZynqMP IPI
mbox with TX/RX channels.
[    3.217581] FPGA manager framework
[....]
[    3.439816] fpga_manager fpga0: Xilinx ZynqMP FPGA Manager
registered
[    3.440223] xlnx_pr_decoupler a0080000.user_proc_bridge: fpga bridge
[Xilinx DFX AXI shutdown mgr] registered


[....]
falcon login: root
root@falcon:~# mkdir /sys/kernel/config/device-tree/overlays/user
partialBitstream-average-fwonly.dtbo     partialBitstream-average-
nobridge.dtbo   partialBitstream-average-
nofw.dtbo       partialBitstream-average-nopartial.dtbo
root@falcon:~# cat full.dtbo > /sys/kernel/config/device-
tree/overlays/user/dtbo 
[   92.045900] fpga_manager fpga0: writing partialBitstream-average.bit 
to Xilinx ZynqMP FPGA Manager
[  104.099858] OF: overlay: WARNING: memory leak will occur if overlay
removed, property: /fpga-full/reconf_region0/fpga-bridges
[  104.111882] OF: overlay: WARNING: memory leak will occur if overlay
removed, property: /fpga-full/reconf_region0/firmware-name
root@falcon:~#

--- END LOG ---

When loading the partial bitstream, I get the following log:


U-Boot SPL 2021.01 (Oct 12 2021 - 09:28:42 +0000)
[... irrelevant U-Boot SPL log ...]
U-Boot 2021.01 (Oct 12 2021 - 09:28:42 +0000)
[... irrelevant U-Boot log ...]
Scanning mmc 1:1...
Found U-Boot script /boot.scr
509 bytes read in 6 ms (82 KiB/s)
## Executing script at 20000000
26510890 bytes read in 1786 ms (14.2 MiB/s)
  design filename = "Falcon;UserID=0XFFFFFFFF;Version=2021.1"
  part number = "xczu6eg-ffvc900-1-i"
  date = "2021/12/20"
  time = "16:29:50"
  bytes in bitstream = 26510780
zynqmp_align_dma_buffer: Align buffer at 000000000010006e to
00000000000fff80(swap 0)
49559 bytes read in 16 ms (3 MiB/s)
21019136 bytes read in 1413 ms (14.2 MiB/s)
## Flattened Device Tree blob at 00100000
   Booting using the fdt blob at 0x100000
   Loading Device Tree to 000000007de03000, end 000000007de12196 ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 5.10.0-xilinx-v2021.1 (oe-user@oe-host)
(aarch64-poky-linux-gcc (GCC) 10.2.0, GNU ld (GNU Binutils)
2.36.1.20210209) #1 SMP Tue Oct 12 09:30:57 UTC 2021
[....]
[    0.000000] Kernel command line: video=DP-1:1920x1080 xilinx-
video.is_mplane=0 root=/dev/mmcblk1p2 rw rootwait earlycon
clk_ignore_unused
[....]
[    2.372821] zynqmp-ipi-mbox mailbox@ff990400: Registered ZynqMP IPI
mbox with TX/RX channels.
[    2.373018] FPGA manager framework
[....]
[    2.595794] fpga_manager fpga0: Xilinx ZynqMP FPGA Manager
registered
[    2.596206] xlnx_pr_decoupler a0080000.user_proc_bridge: fpga bridge
[Xilinx DFX AXI shutdown mgr] registered


[....]
falcon login: root
root@falcon:~# mkdir /sys/kernel/config/device-tree/overlays/user
root@falcon:~# file /lib/firmware/partial.bit
/lib/firmware/partial.bit: Xilinx BIT data - from
Falcon;PARTIAL=TRUE;UserID=0XFFFFFFFF;COMPRESS=FALSE;Version=2021.1 -
for xczu6eg-ffvc900-1-i - built 2021/12/20(16:35:18) - data length
0xf4510
root@falcon:~# cat partial.dtbo > /sys/kernel/config/device-
tree/overlays/user/dtbo 
[  259.672997] fpga_manager fpga0: writing partialBitstream-average.bit 
to Xilinx ZynqMP FPGA Manager

[ system crash at this point ]
--- END LOG ---

The result of the Vivado Hardware manager is here: 
https://nextcloud.bfh.science/index.php/s/HWSEfzawEm2kWpa

As you can see, the System ILA triggerd on a AWVALID signal rising edge
with the 0xA0080000 address (the address of the bridge). There does not
appear to be a read to that address which would check the the
decoupling actually happened.

Is is possible that there is a delay missing when the overlay is
applied? This delay is present since I have to type the command when I
do it manually (and then it works).

> Regards,
> Navakishore.

Best regards
Simon

