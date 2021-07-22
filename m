Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E23E3D1C59
	for <lists+linux-fpga@lfdr.de>; Thu, 22 Jul 2021 05:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhGVCkV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 21 Jul 2021 22:40:21 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:39526 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhGVCkV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 21 Jul 2021 22:40:21 -0400
Received: by mail-pj1-f54.google.com with SMTP id k4-20020a17090a5144b02901731c776526so2245616pjm.4;
        Wed, 21 Jul 2021 20:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jMf5XsCEjptk62J3Iezw8If6gGn0xT3YdZTgNXYfsio=;
        b=EJHOK5kUA3PAeVb6QBfLdo71PLQM6w2u8eO/VIKCH6PfpvK8yjwLoK2HiISXCFDtwB
         Z7htLiCipX5GmZShbQ8lkaABHzqj3Y1VE0AO/YP7j2DITXi6UcuNfaS/pbDaBp3qGDFz
         +Isr2JC4GS2TEG7kePdQTltl9fwK2vjTRpj3TqF8NcsPWeGFdxx9+ryD8sHK7tUsogXh
         Jd4S8ea3sX8oEpFPUYzRnYpWF70GsoaKGxCvkmf1+7H0ogP60M4YqLg4XdBdM/94cvv6
         vpamowyJRryGBw1mEGWUS+8FJA0oraCWiUE+X6h9jlBw9u9acKJV+OOldWG/uZSPUtCs
         s3Dg==
X-Gm-Message-State: AOAM533LnvVaD7MnVevKCT514PNgWBRCf/n4kT6Pje1xNX43LJ9mU8hk
        NcVmVccstKnYT9xxDpTxnnI=
X-Google-Smtp-Source: ABdhPJwQlUF7Oq4SOHUc4n4oaswNiR7jQYp3JrrwGNzkwp2Hw+Ap0MGqWc1w23QcGF+0daYDxarvtA==
X-Received: by 2002:a63:2116:: with SMTP id h22mr14046158pgh.410.1626924055530;
        Wed, 21 Jul 2021 20:20:55 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id q11sm1236549pjd.30.2021.07.21.20.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 20:20:54 -0700 (PDT)
Date:   Wed, 21 Jul 2021 20:20:53 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org,
        "mdf@kernel.org" <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, yliu@xilinx.com,
        michal.simek@xilinx.com, stefanos@xilinx.com,
        devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH V8 XRT Alveo 00/14] XRT Alveo driver overview
Message-ID: <YPjkFYVZuQ7a0unk@epycbox.lan>
References: <20210719212628.134129-1-lizhi.hou@xilinx.com>
 <73448caa-3282-b12f-c11b-4d41bf654f72@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73448caa-3282-b12f-c11b-4d41bf654f72@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi all,

On Tue, Jul 20, 2021 at 12:01:34PM -0700, Tom Rix wrote:
> 
> On 7/19/21 2:26 PM, Lizhi Hou wrote:
> > Hello,
> > 
> > This is V8 of patch series which adds management physical function driver
> > for Xilinx Alveo PCIe accelerator cards.
> >      https://www.xilinx.com/products/boards-and-kits/alveo.html
> > 
> > This driver is part of Xilinx Runtime (XRT) open source stack.
> > 
> > XILINX ALVEO PLATFORM ARCHITECTURE
> > 
> > Alveo PCIe FPGA based platforms have a static *shell* partition and a
> > partial re-configurable *user* partition. The shell partition is
> > automatically loaded from flash when host is booted and PCIe is enumerated
> > by BIOS. Shell cannot be changed till the next cold reboot. The shell
> > exposes two PCIe physical functions:
> > 
> > 1. management physical function
> > 2. user physical function
> > 
> > The patch series includes Documentation/xrt.rst which describes Alveo
> > platform, XRT driver architecture and deployment model in more detail.
> > 
> > Users compile their high level design in C/C++/OpenCL or RTL into FPGA
> > image using Vitis tools.
> >      https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html
> > 
> > The compiled image is packaged as xclbin which contains partial bitstream
> > for the user partition and necessary metadata. Users can dynamically swap
> > the image running on the user partition in order to switch between
> > different workloads by loading different xclbins.
> > 
> > XRT DRIVERS FOR XILINX ALVEO
> > 
> > XRT Linux kernel driver *xrt-mgmt* binds to management physical function of
> > Alveo platform. The modular driver framework is organized into several
> > platform drivers which primarily handle the following functionality:
> > 
> > 1.  Loading firmware container also called xsabin at driver attach time
> > 2.  Loading of user compiled xclbin with FPGA Manager integration
> > 3.  Clock scaling of image running on user partition
> > 4.  In-band sensors: temp, voltage, power, etc.
> > 5.  Device reset and rescan
> > 
> > The platform drivers are packaged into *xrt-lib* helper module with well
> > defined interfaces. The module provides a pseudo-bus implementation for the
> > platform drivers. More details on the driver model can be found in
> > Documentation/xrt.rst.
> > 
> > User physical function driver is not included in this patch series.
> > 
> > LIBFDT REQUIREMENT
> > 
> > XRT driver infrastructure uses Device Tree as a metadata format to discover
> > HW subsystems in the Alveo PCIe device. The Device Tree schema used by XRT
> > is documented in Documentation/xrt.rst.
> > 
> > TESTING AND VALIDATION
> > 
> > xrt-mgmt driver can be tested with full XRT open source stack which
> > includes user space libraries, board utilities and (out of tree) first
> > generation user physical function driver xocl. XRT open source runtime
> > stack is available at https://github.com/Xilinx/XRT
> > 
> > Complete documentation for XRT open source stack including sections on
> > Alveo/XRT security and platform architecture can be found here:
> > 
> > https://xilinx.github.io/XRT/master/html/index.html
> > https://xilinx.github.io/XRT/master/html/security.html
> > https://xilinx.github.io/XRT/master/html/platforms_partitions.html
> > 
> > Changes since v7:
> > - Followed review comment to remove non fpga subdevices:
> >     clock, clkfrq, ucs, ddr_calibaration, devctl and vsec
> > - Collapsed include/uapi/linux/xrt/*.h into include/uapi/linux/fpga-xrt.h
> > - Cleaned up comments in fpga-xrt.h
> > - Fixed spelling errors in xrt.rst
> 
> Lizhi,
> 
> Thanks, the changes look good.
> 
> Moritz,
> 
> I have no outstanding issues and I do not believe there are any from anyone
> else.
> 
> Can this set be included in fpga-next ?

I'll get to it this weekend, apologies for the delay guys.

- Moritz
