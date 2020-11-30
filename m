Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DCB2C8C39
	for <lists+linux-fpga@lfdr.de>; Mon, 30 Nov 2020 19:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbgK3SJb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 30 Nov 2020 13:09:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:54848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387935AbgK3SJb (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 30 Nov 2020 13:09:31 -0500
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCE702074A;
        Mon, 30 Nov 2020 18:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606759730;
        bh=d9yV1lEnxveUgluSCBhCoa0hj6naPZXSjmqKjTGnqZM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N6+Rb6NqtVzTm7cj5nI5LTYGHTw+f/9KD7YKEhPTp37nUluml0326Lt9AYPNb+7v+
         FKZ91iOd6v2r6MJOe0s7i80u/YQeZv+o3IoGk5PcckK1us/9Kk+dBplNZKTnYfjm2i
         VAONbr7C48ySDw3DgZBh9Z+iGkLQDOgFZafyRKH0=
Received: by mail-ed1-f46.google.com with SMTP id m16so17445596edr.3;
        Mon, 30 Nov 2020 10:08:49 -0800 (PST)
X-Gm-Message-State: AOAM532MxsZQDJFA/Q43fF7V4LeW5X7YoVibF+5TqE1gFrFC9fdYwAdm
        HoBUpRg3polj2mTJLtEgS8+NLN3hY9ZUVHJRCQ==
X-Google-Smtp-Source: ABdhPJyalbIM7zr/ARvNlPV82k6Cgt37L4bcmR5TSLk5r69qVnqord2DUkoKhs5fFIwJgGOnz5KCzKqjvzYlAfk1W3c=
X-Received: by 2002:aa7:c80c:: with SMTP id a12mr13080489edt.165.1606759728286;
 Mon, 30 Nov 2020 10:08:48 -0800 (PST)
MIME-Version: 1.0
References: <20201129000040.24777-1-sonals@xilinx.com>
In-Reply-To: <20201129000040.24777-1-sonals@xilinx.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 30 Nov 2020 11:08:36 -0700
X-Gmail-Original-Message-ID: <CAL_JsqLod6FBGFhu7WXtMrB_z7wj8-up0EetM1QS9M3gjm8d7Q@mail.gmail.com>
Message-ID: <CAL_JsqLod6FBGFhu7WXtMrB_z7wj8-up0EetM1QS9M3gjm8d7Q@mail.gmail.com>
Subject: Re: [PATCH Xilinx Alveo 0/8] Xilinx Alveo/XRT patch overview
To:     Sonal Santan <sonal.santan@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sonal Santan <sonals@xilinx.com>, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, lizhih@xilinx.com,
        Michal Simek <michal.simek@xilinx.com>,
        Stefano Stabellini <stefanos@xilinx.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Nov 28, 2020 at 5:02 PM Sonal Santan <sonal.santan@xilinx.com> wrote:
>
> Hello,
>
> This patch series adds management physical function driver for Xilinx Alveo PCIe
> accelerator cards, https://www.xilinx.com/products/boards-and-kits/alveo.html
> This driver is part of Xilinx Runtime (XRT) open source stack.
>
> The patch depends on the "PATCH Xilinx Alveo libfdt prep" which was posted
> before.
>
> ALVEO PLATFORM ARCHITECTURE
>
> Alveo PCIe FPGA based platforms have a static *shell* partition and a partial
> re-configurable *user* partition. The shell partition is automatically loaded from
> flash when host is booted and PCIe is enumerated by BIOS. Shell cannot be changed
> till the next cold reboot. The shell exposes two PCIe physical functions:
>
> 1. management physical function
> 2. user physical function
>
> The patch series includes Documentation/xrt.rst which describes Alveo
> platform, xmgmt driver architecture and deployment model in more more detail.
>
> Users compile their high level design in C/C++/OpenCL or RTL into FPGA image
> using Vitis https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html
> tools. The image is packaged as xclbin and contains partial bitstream for the
> user partition and necessary metadata. Users can dynamically swap the image
> running on the user partition in order to switch between different workloads.
>
> ALVEO DRIVERS
>
> Alveo Linux kernel driver *xmgmt* binds to management physical function of
> Alveo platform. The modular driver framework is organized into several
> platform drivers which primarily handle the following functionality:
>
> 1.  Loading firmware container also called xsabin at driver attach time
> 2.  Loading of user compiled xclbin with FPGA Manager integration
> 3.  Clock scaling of image running on user partition
> 4.  In-band sensors: temp, voltage, power, etc.
> 5.  Device reset and rescan
> 6.  Flashing static *shell* partition
>
> The platform drivers are packaged into *xrt-lib* helper module with a well
> defined interfaces the details of which can be found in Documentation/xrt.rst.
>
> xmgmt driver is second generation Alveo management driver and evolution of
> the first generation (out of tree) Alveo management driver, xclmgmt. The
> sources of the first generation drivers were posted on LKML last year--
> https://lore.kernel.org/lkml/20190319215401.6562-1-sonal.santan@xilinx.com/
>
> Changes since the first generation driver include the following: the driver
> has been re-architected as data driven modular driver; the driver has been
> split into xmgmt and xrt-lib; user physical function driver has been removed
> from the patch series.
>
> Alveo/XRT security and platform architecture is documented on the following
> GitHub pages:
> https://xilinx.github.io/XRT/master/html/security.html
> https://xilinx.github.io/XRT/master/html/platforms_partitions.html
>
> User physical function driver is not included in this patch series.
>
> TESTING AND VALIDATION
>
> xmgmt driver can be tested with full XRT open source stack which includes
> user space libraries, board utilities and (out of tree) first generation
> user physical function driver xocl. XRT open source runtime stack is
> available at https://github.com/Xilinx/XRT. This patch series has been
> validated on Alveo U50 platform.
>
> Complete documentation for XRT open source stack can be found here--
> https://xilinx.github.io/XRT/master/html/index.html

I've not gotten into the patch details, but I'm not clear on what the
lifecycle of the DT looks like here. What's the starting point and
what manipulations to the DT are being done? I'm trying to understand
if using libfdt is the right way versus operating on an unflattened
tree.

Rob
