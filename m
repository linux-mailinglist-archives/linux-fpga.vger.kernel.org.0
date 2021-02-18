Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F40F31ED2D
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Feb 2021 18:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhBRRVN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Feb 2021 12:21:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43020 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231636AbhBRNy4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Feb 2021 08:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613656363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zz+FqegjMz5JGXuvmBa9a3vxdNBIpLKnVH/ppFmB+04=;
        b=go5tj/qTolJUfK9urwoVms/YybsF7HWfDAWXSJHsAkCOJH65Pat3xIK8y1vQQlBCEe8Ssf
        GlXQn6CAOPSFOUlH6SFMdvaCnl7J6cNxLbl9SihOxno3cynRSLvsGU/iqsHkVgXHuYBlY1
        S/DYd6CW928gkNUiy3alINrbrbBB9ls=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-LSbWT8VIP_CEh2fKUZ61aQ-1; Thu, 18 Feb 2021 08:52:40 -0500
X-MC-Unique: LSbWT8VIP_CEh2fKUZ61aQ-1
Received: by mail-qv1-f71.google.com with SMTP id z28so1126999qva.15
        for <linux-fpga@vger.kernel.org>; Thu, 18 Feb 2021 05:52:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Zz+FqegjMz5JGXuvmBa9a3vxdNBIpLKnVH/ppFmB+04=;
        b=VoVN+5gG6aU6kB4nPdVWxzdx31sDrlUazBPPgeWhKIZX/1qNftjXCZi4QeFfEa4rAy
         B6we6vTPtMIhangZSvxjd9Vi0AWCanSFD+VsI0gYUNhTHauuCGERYTKzqQbeu4PdbQo9
         jCYpqlzSHa2JYWll0FxFwZ3iWVnOiwN63FiRusVTLgqr05Y+yX3GnflhioEWSTdHGnfR
         BPWZldxuZQwe4vb6FNSHxUwIhveEgk1pSMOi6PWuZ3CHTP7v8bUZg9LnSRwHwhOxgy3v
         eHce0lD6Z4oNdAUEbC/iFVRR334b96mNJXGPZZxmQbomxeGNPKPHIjgsA6KcOX3wCBXF
         kQjg==
X-Gm-Message-State: AOAM533DjuajeaKWG72rsu34EqhphnvolrPZ/e1moBw0N0mcmroxqyCV
        3KJJZFANvwkCJhZZIB9aRh53pT4IcPdNi2wElPfqOPxoYqBwNHUXUgBN550X0a22lqABM8xjYzN
        G4kOdNrloowUT7vz4QL8r1Q==
X-Received: by 2002:a05:6214:118d:: with SMTP id t13mr4085307qvv.33.1613656360050;
        Thu, 18 Feb 2021 05:52:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5yZ21hFqadoEzbvV1ITzft3gVOFNPV5P2Bz1lxUpESujsok5c8qpJ1GpduNWpZL8n5Jt7MA==
X-Received: by 2002:a05:6214:118d:: with SMTP id t13mr4085274qvv.33.1613656359711;
        Thu, 18 Feb 2021 05:52:39 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r18sm3333997qtm.54.2021.02.18.05.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 05:52:39 -0800 (PST)
Subject: Re: [PATCH V3 XRT Alveo 00/18] XRT Alveo driver overview
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     Lizhi Hou <lizhih@xilinx.com>, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org
References: <20210218064019.29189-1-lizhih@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <61668981-328b-64ea-0509-950172e5250c@redhat.com>
Date:   Thu, 18 Feb 2021 05:52:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218064019.29189-1-lizhih@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/17/21 10:40 PM, Lizhi Hou wrote:
> Hello,
>
> This is V3 of patch series which adds management physical function driver for Xilinx
> Alveo PCIe accelerator cards, https://www.xilinx.com/products/boards-and-kits/alveo.html
> This driver is part of Xilinx Runtime (XRT) open source stack.
>
> XILINX ALVEO PLATFORM ARCHITECTURE

Thanks for refreshing this patchset.

It will take me a while to do the full review, so I thought I would give some early feed back.

It applies to char-misc-next, but will have conflicts with in-flight patches around the MAINTAINERS file. This is not a big deal.

The checkpatch is much better over v2, the complaints are

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#21:
new file mode 100644

WARNING: From:/Signed-off-by: email address mismatch: 'From: Lizhi Hou <lizhi.hou@xilinx.com>' != 'Signed-off-by: Lizhi Hou <lizhih@xilinx.com>'

MAINTAINERS warning i believe you address in the last patch.

In the next revisions, please fix the signoff.

The test robot is complaining about hppa64.  While it may be an unlikely config, it would be best to fix it.

Tom

>
> Alveo PCIe FPGA based platforms have a static *shell* partition and a partial
> re-configurable *user* partition. The shell partition is automatically loaded from
> flash when host is booted and PCIe is enumerated by BIOS. Shell cannot be changed
> till the next cold reboot. The shell exposes two PCIe physical functions:
>
> 1. management physical function
> 2. user physical function
>
> The patch series includes Documentation/xrt.rst which describes Alveo platform,
> XRT driver architecture and deployment model in more detail.
>
> Users compile their high level design in C/C++/OpenCL or RTL into FPGA image using
> Vitis https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html
> tools. The compiled image is packaged as xclbin which contains partial bitstream
> for the user partition and necessary metadata. Users can dynamically swap the image
> running on the user partition in order to switch between different workloads by
> loading different xclbins.
>
> XRT DRIVERS FOR XILINX ALVEO
>
> XRT Linux kernel driver *xmgmt* binds to management physical function of Alveo
> platform. The modular driver framework is organized into several platform drivers
> which primarily handle the following functionality:
>
> 1.  Loading firmware container also called xsabin at driver attach time
> 2.  Loading of user compiled xclbin with FPGA Manager integration
> 3.  Clock scaling of image running on user partition
> 4.  In-band sensors: temp, voltage, power, etc.
> 5.  Device reset and rescan
>
> The platform drivers are packaged into *xrt-lib* helper module with well
> defined interfaces. The module provides a pseudo-bus implementation for the
> platform drivers. More details on the driver model can be found in
> Documentation/xrt.rst.
>
> User physical function driver is not included in this patch series.
>
> LIBFDT REQUIREMENT
>
> XRT driver infrastructure uses Device Tree as a metadata format to discover
> HW subsystems in the Alveo PCIe device. The Device Tree schema used by XRT
> is documented in Documentation/xrt.rst. Unlike previous V1 and V2 version
> of patch series, V3 version does not require export of libfdt symbols.
>
> TESTING AND VALIDATION
>
> xmgmt driver can be tested with full XRT open source stack which includes user
> space libraries, board utilities and (out of tree) first generation user physical
> function driver xocl. XRT open source runtime stack is available at
> https://github.com/Xilinx/XRT
>
> Complete documentation for XRT open source stack including sections on Alveo/XRT
> security and platform architecture can be found here:
>
> https://xilinx.github.io/XRT/master/html/index.html
> https://xilinx.github.io/XRT/master/html/security.html
> https://xilinx.github.io/XRT/master/html/platforms_partitions.html
>
> Changes since v2:
> - Streamlined the driver framework into *xleaf*, *group* and *xroot*
> - Updated documentation to show the driver model with examples
> - Addressed kernel test robot errors
> - Added a selftest for basic driver framework
> - Documented device tree schema
> - Removed need to export libfdt symbols
>
> Changes since v1:
> - Updated the driver to use fpga_region and fpga_bridge for FPGA
>   programming
> - Dropped platform drivers not related to PR programming to focus on XRT
>   core framework
> - Updated Documentation/fpga/xrt.rst with information on XRT core framework
> - Addressed checkpatch issues
> - Dropped xrt- prefix from some header files
>
> For reference V1 version of patch series can be found here:
>
> https://lore.kernel.org/lkml/20201217075046.28553-1-sonals@xilinx.com/
> https://lore.kernel.org/lkml/20201217075046.28553-2-sonals@xilinx.com/
> https://lore.kernel.org/lkml/20201217075046.28553-3-sonals@xilinx.com/
> https://lore.kernel.org/lkml/20201217075046.28553-4-sonals@xilinx.com/
> https://lore.kernel.org/lkml/20201217075046.28553-5-sonals@xilinx.com/
> https://lore.kernel.org/lkml/20201217075046.28553-6-sonals@xilinx.com/
> https://lore.kernel.org/lkml/20201217075046.28553-7-sonals@xilinx.com/
>
> Lizhi Hou (18):
>   Documentation: fpga: Add a document describing XRT Alveo drivers
>   fpga: xrt: driver metadata helper functions
>   fpga: xrt: xclbin file helper functions
>   fpga: xrt: xrt-lib platform driver manager
>   fpga: xrt: group platform driver
>   fpga: xrt: platform driver infrastructure
>   fpga: xrt: management physical function driver (root)
>   fpga: xrt: main platform driver for management function device
>   fpga: xrt: fpga-mgr and region implementation for xclbin download
>   fpga: xrt: VSEC platform driver
>   fpga: xrt: UCS platform driver
>   fpga: xrt: ICAP platform driver
>   fpga: xrt: devctl platform driver
>   fpga: xrt: clock platform driver
>   fpga: xrt: clock frequence counter platform driver
>   fpga: xrt: DDR calibration platform driver
>   fpga: xrt: partition isolation platform driver
>   fpga: xrt: Kconfig and Makefile updates for XRT drivers
>
>  Documentation/fpga/index.rst             |   1 +
>  Documentation/fpga/xrt.rst               | 842 ++++++++++++++++++++++
>  MAINTAINERS                              |  11 +
>  drivers/Makefile                         |   1 +
>  drivers/fpga/Kconfig                     |   2 +
>  drivers/fpga/Makefile                    |   4 +
>  drivers/fpga/xrt/Kconfig                 |   8 +
>  drivers/fpga/xrt/include/events.h        |  48 ++
>  drivers/fpga/xrt/include/group.h         |  27 +
>  drivers/fpga/xrt/include/metadata.h      | 229 ++++++
>  drivers/fpga/xrt/include/subdev_id.h     |  43 ++
>  drivers/fpga/xrt/include/xclbin-helper.h |  52 ++
>  drivers/fpga/xrt/include/xleaf.h         | 276 +++++++
>  drivers/fpga/xrt/include/xleaf/axigate.h |  25 +
>  drivers/fpga/xrt/include/xleaf/calib.h   |  30 +
>  drivers/fpga/xrt/include/xleaf/clkfreq.h |  23 +
>  drivers/fpga/xrt/include/xleaf/clock.h   |  31 +
>  drivers/fpga/xrt/include/xleaf/devctl.h  |  43 ++
>  drivers/fpga/xrt/include/xleaf/icap.h    |  29 +
>  drivers/fpga/xrt/include/xleaf/ucs.h     |  24 +
>  drivers/fpga/xrt/include/xmgmt-main.h    |  37 +
>  drivers/fpga/xrt/include/xroot.h         | 114 +++
>  drivers/fpga/xrt/lib/Kconfig             |  16 +
>  drivers/fpga/xrt/lib/Makefile            |  30 +
>  drivers/fpga/xrt/lib/cdev.c              | 231 ++++++
>  drivers/fpga/xrt/lib/group.c             | 265 +++++++
>  drivers/fpga/xrt/lib/main.c              | 274 +++++++
>  drivers/fpga/xrt/lib/main.h              |  17 +
>  drivers/fpga/xrt/lib/subdev.c            | 871 +++++++++++++++++++++++
>  drivers/fpga/xrt/lib/subdev_pool.h       |  53 ++
>  drivers/fpga/xrt/lib/xclbin.c            | 394 ++++++++++
>  drivers/fpga/xrt/lib/xleaf/axigate.c     | 298 ++++++++
>  drivers/fpga/xrt/lib/xleaf/calib.c       | 226 ++++++
>  drivers/fpga/xrt/lib/xleaf/clkfreq.c     | 221 ++++++
>  drivers/fpga/xrt/lib/xleaf/clock.c       | 648 +++++++++++++++++
>  drivers/fpga/xrt/lib/xleaf/devctl.c      | 206 ++++++
>  drivers/fpga/xrt/lib/xleaf/icap.c        | 317 +++++++++
>  drivers/fpga/xrt/lib/xleaf/ucs.c         | 235 ++++++
>  drivers/fpga/xrt/lib/xleaf/vsec.c        | 359 ++++++++++
>  drivers/fpga/xrt/lib/xroot.c             | 598 ++++++++++++++++
>  drivers/fpga/xrt/metadata/Kconfig        |  12 +
>  drivers/fpga/xrt/metadata/Makefile       |  16 +
>  drivers/fpga/xrt/metadata/metadata.c     | 524 ++++++++++++++
>  drivers/fpga/xrt/mgmt/Kconfig            |  15 +
>  drivers/fpga/xrt/mgmt/Makefile           |  19 +
>  drivers/fpga/xrt/mgmt/fmgr-drv.c         | 187 +++++
>  drivers/fpga/xrt/mgmt/fmgr.h             |  28 +
>  drivers/fpga/xrt/mgmt/main-impl.h        |  37 +
>  drivers/fpga/xrt/mgmt/main-region.c      | 471 ++++++++++++
>  drivers/fpga/xrt/mgmt/main.c             | 693 ++++++++++++++++++
>  drivers/fpga/xrt/mgmt/root.c             | 342 +++++++++
>  include/uapi/linux/xrt/xclbin.h          | 408 +++++++++++
>  include/uapi/linux/xrt/xmgmt-ioctl.h     |  46 ++
>  53 files changed, 9957 insertions(+)
>  create mode 100644 Documentation/fpga/xrt.rst
>  create mode 100644 drivers/fpga/xrt/Kconfig
>  create mode 100644 drivers/fpga/xrt/include/events.h
>  create mode 100644 drivers/fpga/xrt/include/group.h
>  create mode 100644 drivers/fpga/xrt/include/metadata.h
>  create mode 100644 drivers/fpga/xrt/include/subdev_id.h
>  create mode 100644 drivers/fpga/xrt/include/xclbin-helper.h
>  create mode 100644 drivers/fpga/xrt/include/xleaf.h
>  create mode 100644 drivers/fpga/xrt/include/xleaf/axigate.h
>  create mode 100644 drivers/fpga/xrt/include/xleaf/calib.h
>  create mode 100644 drivers/fpga/xrt/include/xleaf/clkfreq.h
>  create mode 100644 drivers/fpga/xrt/include/xleaf/clock.h
>  create mode 100644 drivers/fpga/xrt/include/xleaf/devctl.h
>  create mode 100644 drivers/fpga/xrt/include/xleaf/icap.h
>  create mode 100644 drivers/fpga/xrt/include/xleaf/ucs.h
>  create mode 100644 drivers/fpga/xrt/include/xmgmt-main.h
>  create mode 100644 drivers/fpga/xrt/include/xroot.h
>  create mode 100644 drivers/fpga/xrt/lib/Kconfig
>  create mode 100644 drivers/fpga/xrt/lib/Makefile
>  create mode 100644 drivers/fpga/xrt/lib/cdev.c
>  create mode 100644 drivers/fpga/xrt/lib/group.c
>  create mode 100644 drivers/fpga/xrt/lib/main.c
>  create mode 100644 drivers/fpga/xrt/lib/main.h
>  create mode 100644 drivers/fpga/xrt/lib/subdev.c
>  create mode 100644 drivers/fpga/xrt/lib/subdev_pool.h
>  create mode 100644 drivers/fpga/xrt/lib/xclbin.c
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/axigate.c
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/calib.c
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/clkfreq.c
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/clock.c
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/devctl.c
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/icap.c
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/ucs.c
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/vsec.c
>  create mode 100644 drivers/fpga/xrt/lib/xroot.c
>  create mode 100644 drivers/fpga/xrt/metadata/Kconfig
>  create mode 100644 drivers/fpga/xrt/metadata/Makefile
>  create mode 100644 drivers/fpga/xrt/metadata/metadata.c
>  create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
>  create mode 100644 drivers/fpga/xrt/mgmt/Makefile
>  create mode 100644 drivers/fpga/xrt/mgmt/fmgr-drv.c
>  create mode 100644 drivers/fpga/xrt/mgmt/fmgr.h
>  create mode 100644 drivers/fpga/xrt/mgmt/main-impl.h
>  create mode 100644 drivers/fpga/xrt/mgmt/main-region.c
>  create mode 100644 drivers/fpga/xrt/mgmt/main.c
>  create mode 100644 drivers/fpga/xrt/mgmt/root.c
>  create mode 100644 include/uapi/linux/xrt/xclbin.h
>  create mode 100644 include/uapi/linux/xrt/xmgmt-ioctl.h
>

