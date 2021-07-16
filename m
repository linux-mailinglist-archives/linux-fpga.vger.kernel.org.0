Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BF73CBDD9
	for <lists+linux-fpga@lfdr.de>; Fri, 16 Jul 2021 22:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhGPUjH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 16 Jul 2021 16:39:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34551 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232888AbhGPUjH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 16 Jul 2021 16:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626467771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y/JNdOdZc0YWTfnh0jSQbC1+dZjo3aW2HziJArOD7t4=;
        b=iU3oYM9fNkiV4JStw2jfVKawNbb4udsX2Rn1mEU18Mq+Xlqt0dQOVoX26fv7KZvselw3My
        4dTLcJzypkJtubZytyTn48EKsxaoyK07QLJdpYHMkOJXnD8mQmNU3aHGdKa/8XzV1BnQm3
        H1tInAFSUvVM11R0eAQGJj7DLITHyOg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-l8AIrhXaPwmakwy0qomAow-1; Fri, 16 Jul 2021 16:36:10 -0400
X-MC-Unique: l8AIrhXaPwmakwy0qomAow-1
Received: by mail-qk1-f199.google.com with SMTP id 81-20020a370b540000b02903b854c43335so7207733qkl.21
        for <linux-fpga@vger.kernel.org>; Fri, 16 Jul 2021 13:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=y/JNdOdZc0YWTfnh0jSQbC1+dZjo3aW2HziJArOD7t4=;
        b=QCr5uHSQmq/8v4LUNteLCp2idb30UbNWbYDGpDgolZAB6JKtLby6qwsIrpS3FPkl4n
         zr0vR6BvdZ9aV/bGXMEdtbYvDhJJjPZNyJWPGxDYS3AqdBy8J1JNGQMwqUhpSLOBge7m
         JH8i+e0tIY5UOXJAhi3frw1souCz7+ZAzkp7OFZh77LyWQ8JB5qcir99ffamAjXOufxy
         YKk5wnVFPAN4k7x8PttjCDUklwvZ9rLbwGTrWWZ0QSfZoFr8q2AsNrQ0thRAhGiVDVHT
         8mppILkV/XzBxHm/3vpHvqoPw/Rm73CW3M56+EG2bClxkUBCMxBQfC7+DH2apWvmIyid
         u1+w==
X-Gm-Message-State: AOAM532cazRqV7OJQMg63khQfLLpsNMnbe9+W1iC9iNgiSaSBdID2Fp5
        Mt1lHJl2wLIuLuL5GRlydqytlipiUWswOJQuG36tKUb+UsP1POFx9O5qYboVdV3fGVijtKGvi8g
        4PdRuTpB01pzPR5YhnUATng==
X-Received: by 2002:ad4:5bec:: with SMTP id k12mr12088153qvc.5.1626467769556;
        Fri, 16 Jul 2021 13:36:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfvkIs3JF1n7n4aRuLOG5lB6pMuKdEDEBfYu8OQVPNIOYs7y8AHYUDK2Ybd58N8I5UPcxlbw==
X-Received: by 2002:ad4:5bec:: with SMTP id k12mr12088104qvc.5.1626467769115;
        Fri, 16 Jul 2021 13:36:09 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z68sm4384754qke.86.2021.07.16.13.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 13:36:08 -0700 (PDT)
Subject: Re: [PATCH V7 XRT Alveo 00/20] XRT Alveo driver overview
To:     Lizhi Hou <lizhih@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>
Cc:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Max Zhen <maxz@xilinx.com>, Sonal Santan <sonals@xilinx.com>,
        Yu Liu <yliu@xilinx.com>, Michal Simek <michals@xilinx.com>,
        Stefano Stabellini <stefanos@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>
References: <20210528004959.61354-1-lizhi.hou@xilinx.com>
 <0677c3b8-87a8-7092-0c63-36de55a4de4d@redhat.com>
 <7290da0c-0e6f-81e3-e1b8-087536110569@redhat.com>
 <66B9450C-056E-4B2D-85B8-CBAC1D820EAA@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4ba4479f-190b-c118-a39a-6d93edd2f455@redhat.com>
Date:   Fri, 16 Jul 2021 13:36:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <66B9450C-056E-4B2D-85B8-CBAC1D820EAA@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 7/16/21 12:14 PM, Lizhi Hou wrote:
> Hi Tom,
>
> I am working on v8 patchset which I followed your guidance to move the listed xleaf to suggested subsystems. And the spelling error fixes, and fpga-xrt.h cleanup are all included.
> Does that make senses to you? If yes, I may send the V8 patchset early next week for you to review.

Can handling the move be done in a followup ?

AFAIK, there are no other problems with v7 and I would rather see a 
smaller subset of v7 make it intree sooner.

This would mean dropping the (maybe) contentious xleafs from v8 just 
doing the cleanups.

Tom

>
> Thanks,
> Lizhi
>
> ﻿On 7/16/21, 11:27 AM, "Tom Rix" <trix@redhat.com> wrote:
>
>      CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>
>
>      On 7/1/21 1:32 PM, Tom Rix wrote:
>      > Lizhi,
>      >
>      > Sorry for the delay in reviewing v7.
>      >
>      > Is it too early to blame it on the July 4 holiday here ?!? :)
>      >
>      >
>      > All the small stuff looks fine to me.  In this pass I looked at issues
>      > that would need a refactoring.  Since it would be a lot of work and I
>      > am not the final word on this, it would be good if some others to
>      > chime in. Also a couple of new spelling fixes at the end.
>
>      Lizhi
>
>      This pathset has stalled.
>
>      The spelling changes should be fixed.
>
>      Some of xleafs may need to be moved and reworked.
>
>      The addition of building outside of fpga/xrt is a new feature, and I
>      think is best considered when the first foundational change (this
>      patchset) is in tree.
>
>      Could the xleafs' below be dropped from this set ?
>
>      Tom
>
>      >
>      > Tom
>      >
>      >
>      > Having xrt/ dir
>      > ok with it or it will follow the subdir reorg of fpga/, afaik not a
>      > blocker
>      >
>      > Location of xrt_bus_type
>      > ok, similar to dfl_bus_type
>      >
>      > Non fpga subdevices should go to other subsystems.
>      > looking in drivers/fpga/xrt/lib/xleaf
>      >
>      > clock clkfrq ucs these are clocks
>      > should move to drivers/clk/xilinx/
>      >
>      > axigate, for fpga partitioning
>      > ok to stay
>      >
>      > ddr_calibaration, a memory status checker
>      > should move drivers/memory dfl-emif is similar
>      >
>      > devctl, a general purpose misc driver
>      > should move to drivers/mfd
>      >
>      > icap, for fpga bitstream writing
>      > ok to stay
>      >
>      > vsec, misc small drivers discovered via pci config vsec
>      > should move to drivers/mfd
>      >
>      > For include/uapi/linux
>      > collapse include/uapi/linux/xrt/*.h into include/uapi/linux/fpga-xrt.h
>      > There are only 2 files, one really small. fpga-xrt.h follows fpga-dfl.h
>      > The comments are pretty messy, user should be able to scan them.
>      > Try cleaning them up.
>      >
>      > Spelling mistakes
>      >
>      > diff --git a/Documentation/fpga/xrt.rst b/Documentation/fpga/xrt.rst
>      > index 5a5b4d5a3bc6..84eb41be9ac1 100644
>      > --- a/Documentation/fpga/xrt.rst
>      > +++ b/Documentation/fpga/xrt.rst
>      > @@ -275,7 +275,7 @@ fpga_bridge and fpga_region for the next region in
>      > the chain.
>      >  fpga_bridge
>      >  -----------
>      >
>      > -Like the fpga_region, a fpga_bridge is created by walking the device
>      > tree
>      > +Like the fpga_region, an fpga_bridge is created by walking the device
>      > tree
>      >  of the parent group. The bridge is used for isolation between a
>      > parent and
>      >  its child.
>      >
>      > @@ -416,7 +416,7 @@ xclbin is compiled by end user using
>      >  `Vitis
>      > <https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html>`_
>      >  tool set from Xilinx. The xclbin contains sections describing user
>      > compiled
>      >  acceleration engines/kernels, memory subsystems, clocking information
>      > etc. It also
>      > -contains a FPGA bitstream for the user partition, UUIDs, platform
>      > name, etc.
>      > +contains an FPGA bitstream for the user partition, UUIDs, platform
>      > name, etc.
>      >
>      >
>      >  .. _xsabin_xclbin_container_format:
>      > diff --git a/drivers/fpga/xrt/include/metadata.h
>      > b/drivers/fpga/xrt/include/metadata.h
>      > index c4df88262f8a..f48d6d42f5ef 100644
>      > --- a/drivers/fpga/xrt/include/metadata.h
>      > +++ b/drivers/fpga/xrt/include/metadata.h
>      > @@ -194,7 +194,7 @@ int xrt_md_get_interface_uuids(struct device *dev,
>      > const char *blob,
>      >  /*
>      >   * The firmware provides a 128 bit hash string as a unique id to the
>      >   * partition/interface.
>      > - * Existing hw does not yet use the cononical form, so it is
>      > necessary to
>      > + * Existing hw does not yet use the canonical form, so it is
>      > necessary to
>      >   * use a translation function.
>      >   */
>      >  static inline void xrt_md_trans_uuid2str(const uuid_t *uuid, char
>      > *uuidstr)
>      > diff --git a/drivers/fpga/xrt/lib/xroot.c b/drivers/fpga/xrt/lib/xroot.c
>      > index 7b3e540dd6c0..f324a25e1d4d 100644
>      > --- a/drivers/fpga/xrt/lib/xroot.c
>      > +++ b/drivers/fpga/xrt/lib/xroot.c
>      > @@ -427,7 +427,7 @@ static void xroot_bringup_group_work(struct
>      > work_struct *work)
>      >                 r = xleaf_call(xdev, XRT_GROUP_INIT_CHILDREN, NULL);
>      >                 xroot_put_group(xr, xdev);
>      >                 if (r == -EEXIST)
>      > -                       continue; /* Already brough up, nothing to do. */
>      > +                       continue; /* Already brought up, nothing to
>      > do. */
>      >                 if (r)
>      > atomic_inc(&xr->groups.bringup_failed_cnt);
>      >
>      > diff --git a/drivers/fpga/xrt/mgmt/xmgmt-main.c
>      > b/drivers/fpga/xrt/mgmt/xmgmt-main.c
>      > index 820c888e7918..9077254e0f8a 100644
>      > --- a/drivers/fpga/xrt/mgmt/xmgmt-main.c
>      > +++ b/drivers/fpga/xrt/mgmt/xmgmt-main.c
>      > @@ -142,7 +142,7 @@ static ssize_t VBNV_show(struct device *dev,
>      > struct device_attribute *da, char *
>      >  }
>      >  static DEVICE_ATTR_RO(VBNV);
>      >
>      > -/* logic uuid is the uuid uniquely identfy the partition */
>      > +/* logic uuid is the uuid uniquely identify the partition */
>      >  static ssize_t logic_uuids_show(struct device *dev, struct
>      > device_attribute *da, char *buf)
>      >  {
>      >         struct xrt_device *xdev = to_xrt_dev(dev);
>      > diff --git a/drivers/fpga/xrt/mgmt/xrt-mgr.c
>      > b/drivers/fpga/xrt/mgmt/xrt-mgr.c
>      > index 41263a033d9d..ab253b516e8d 100644
>      > --- a/drivers/fpga/xrt/mgmt/xrt-mgr.c
>      > +++ b/drivers/fpga/xrt/mgmt/xrt-mgr.c
>      > @@ -115,7 +115,7 @@ static int xmgmt_pr_write_init(struct fpga_manager
>      > *mgr,
>      >  }
>      >
>      >  /*
>      > - * The implementation requries full xclbin image before we can start
>      > + * The implementation requires full xclbin image before we can start
>      >   * programming the hardware via ICAP subsystem. The full image is
>      > required
>      >   * for checking the validity of xclbin and walking the sections to
>      >   * discover the bitstream.
>      >
>      > On 5/27/21 5:49 PM, Lizhi Hou wrote:
>      >> Hello,
>      >>
>      >> This is V7 of patch series which adds management physical function
>      >> driver
>      >> for Xilinx Alveo PCIe accelerator cards.
>      >>      https://www.xilinx.com/products/boards-and-kits/alveo.html
>      >>
>      >> This driver is part of Xilinx Runtime (XRT) open source stack.
>      >>
>      >> XILINX ALVEO PLATFORM ARCHITECTURE
>      >>
>      >> Alveo PCIe FPGA based platforms have a static *shell* partition and a
>      >> partial re-configurable *user* partition. The shell partition is
>      >> automatically loaded from flash when host is booted and PCIe is
>      >> enumerated
>      >> by BIOS. Shell cannot be changed till the next cold reboot. The shell
>      >> exposes two PCIe physical functions:
>      >>
>      >> 1. management physical function
>      >> 2. user physical function
>      >>
>      >> The patch series includes Documentation/xrt.rst which describes Alveo
>      >> platform, XRT driver architecture and deployment model in more detail.
>      >>
>      >> Users compile their high level design in C/C++/OpenCL or RTL into FPGA
>      >> image using Vitis tools.
>      >> https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html
>      >>
>      >> The compiled image is packaged as xclbin which contains partial
>      >> bitstream
>      >> for the user partition and necessary metadata. Users can dynamically
>      >> swap
>      >> the image running on the user partition in order to switch between
>      >> different workloads by loading different xclbins.
>      >>
>      >> XRT DRIVERS FOR XILINX ALVEO
>      >>
>      >> XRT Linux kernel driver *xrt-mgmt* binds to management physical
>      >> function of
>      >> Alveo platform. The modular driver framework is organized into several
>      >> platform drivers which primarily handle the following functionality:
>      >>
>      >> 1.  Loading firmware container also called xsabin at driver attach time
>      >> 2.  Loading of user compiled xclbin with FPGA Manager integration
>      >> 3.  Clock scaling of image running on user partition
>      >> 4.  In-band sensors: temp, voltage, power, etc.
>      >> 5.  Device reset and rescan
>      >>
>      >> The platform drivers are packaged into *xrt-lib* helper module with well
>      >> defined interfaces. The module provides a pseudo-bus implementation
>      >> for the
>      >> platform drivers. More details on the driver model can be found in
>      >> Documentation/xrt.rst.
>      >>
>      >> User physical function driver is not included in this patch series.
>      >>
>      >> LIBFDT REQUIREMENT
>      >>
>      >> XRT driver infrastructure uses Device Tree as a metadata format to
>      >> discover
>      >> HW subsystems in the Alveo PCIe device. The Device Tree schema used
>      >> by XRT
>      >> is documented in Documentation/xrt.rst.
>      >>
>      >> TESTING AND VALIDATION
>      >>
>      >> xrt-mgmt driver can be tested with full XRT open source stack which
>      >> includes user space libraries, board utilities and (out of tree) first
>      >> generation user physical function driver xocl. XRT open source runtime
>      >> stack is available at https://github.com/Xilinx/XRT
>      >>
>      >> Complete documentation for XRT open source stack including sections on
>      >> Alveo/XRT security and platform architecture can be found here:
>      >>
>      >> https://xilinx.github.io/XRT/master/html/index.html
>      >> https://xilinx.github.io/XRT/master/html/security.html
>      >> https://xilinx.github.io/XRT/master/html/platforms_partitions.html
>      >>
>      >> Changes since v6:
>      >> - Resolved grammatical errors and cleaned up taxonomy in xrt.rst
>      >>    documentation.
>      >> - Fixed clang warnings.
>      >> - Updated code base to include v6 code review comments.
>      >>
>      >> Changes since v5:
>      >> - Revert all changes 'mgnt/MGNT' back to 'mgmt/MGMT'
>      >> - Updated code base to include v5 code review comments.
>      >>     xrt.rst: address grammar and taxonomy
>      >>     subdev_id.h: defines XRT_SUBDEV_INVALID = 0
>      >>     xclbin.c: change shift operation to be_to_cpu
>      >> - Resolved kernel test robot errors.
>      >>
>      >> Changes since v4:
>      >> - Added xrt_bus_type and xrt_device. All sub devices were changed from
>      >>    platform_bus_type/platform_device to xrt_bus_type/xrt_device.
>      >> - Renamed xrt-mgmt driver to xrt-mgnt driver.
>      >> - Replaced 'MGMT' with 'MGNT' and 'mgmt' with 'mgnt' in code and file
>      >> names
>      >> - Moved pci function calls from infrastructure to xrt-mgnt driver.
>      >> - Renamed files: mgmt/main.c -> mgnt/xmgnt-main.c
>      >>                   mgmt/main-region.c -> mgnt/xmgnt-main-region.c
>      >>                   include/xmgmt-main.h -> include/xmgnt-main.h
>      >>                   mgmt/fmgr-drv.c -> mgnt/xrt-mgr.c
>      >>                   mgmt/fmgr.h -> mgnt/xrt-mgr.h
>      >> - Updated code base to include v4 code review comments.
>      >>
>      >> Changes since v3:
>      >> - Leaf drivers use regmap-mmio to access hardware registers.
>      >> - Renamed driver module: xmgmt.ko -> xrt-mgmt.ko
>      >> - Renamed files: calib.[c|h] -> ddr_calibration.[c|h],
>      >>                   lib/main.[c|h] -> lib/lib-drv.[c|h],
>      >>                   mgmt/main-impl.h - > mgmt/xmgnt.h
>      >> - Updated code base to include v3 code review comments.
>      >>
>      >> Changes since v2:
>      >> - Streamlined the driver framework into *xleaf*, *group* and *xroot*
>      >> - Updated documentation to show the driver model with examples
>      >> - Addressed kernel test robot errors
>      >> - Added a selftest for basic driver framework
>      >> - Documented device tree schema
>      >> - Removed need to export libfdt symbols
>      >>
>      >> Changes since v1:
>      >> - Updated the driver to use fpga_region and fpga_bridge for FPGA
>      >>    programming
>      >> - Dropped platform drivers not related to PR programming to focus on XRT
>      >>    core framework
>      >> - Updated Documentation/fpga/xrt.rst with information on XRT core
>      >> framework
>      >> - Addressed checkpatch issues
>      >> - Dropped xrt- prefix from some header files
>      >>
>      >> For reference V6 version of patch series can be found here:
>      >>
>      >> https://lore.kernel.org/lkml/20210512015339.5649-1-lizhi.hou@xilinx.com/
>      >> https://lore.kernel.org/lkml/20210512015339.5649-2-lizhi.hou@xilinx.com/
>      >> https://lore.kernel.org/lkml/20210512015339.5649-3-lizhi.hou@xilinx.com/
>      >> https://lore.kernel.org/lkml/20210512015339.5649-4-lizhi.hou@xilinx.com/
>      >> https://lore.kernel.org/lkml/20210512015339.5649-5-lizhi.hou@xilinx.com/
>      >> https://lore.kernel.org/lkml/20210512015339.5649-6-lizhi.hou@xilinx.com/
>      >> https://lore.kernel.org/lkml/20210512015339.5649-7-lizhi.hou@xilinx.com/
>      >> https://lore.kernel.org/lkml/20210512015339.5649-8-lizhi.hou@xilinx.com/
>      >> https://lore.kernel.org/lkml/20210512015339.5649-9-lizhi.hou@xilinx.com/
>      >> https://lore.kernel.org/lkml/20210512015339.5649-10-lizhi.hou@xilinx.com/
>      >>
>      >> https://lore.kernel.org/lkml/20210512015339.5649-11-lizhi.hou@xilinx.com/
>      >>
>      >> https://lore.kernel.org/lkml/20210512015339.5649-12-lizhi.hou@xilinx.com/
>      >>
>      >> https://lore.kernel.org/lkml/20210512015339.5649-13-lizhi.hou@xilinx.com/
>      >>
>      >> https://lore.kernel.org/lkml/20210512015339.5649-14-lizhi.hou@xilinx.com/
>      >>
>      >> https://lore.kernel.org/lkml/20210512015339.5649-15-lizhi.hou@xilinx.com/
>      >>
>      >> https://lore.kernel.org/lkml/20210512015339.5649-16-lizhi.hou@xilinx.com/
>      >>
>      >> https://lore.kernel.org/lkml/20210512015339.5649-17-lizhi.hou@xilinx.com/
>      >>
>      >> https://lore.kernel.org/lkml/20210512015339.5649-18-lizhi.hou@xilinx.com/
>      >>
>      >> https://lore.kernel.org/lkml/20210512015339.5649-19-lizhi.hou@xilinx.com/
>      >>
>      >> https://lore.kernel.org/lkml/20210512015339.5649-20-lizhi.hou@xilinx.com/
>      >>
>      >> https://lore.kernel.org/lkml/20210512015339.5649-21-lizhi.hou@xilinx.com/
>      >>
>      >>
>      >> Lizhi Hou (20):
>      >>    Documentation: fpga: Add a document describing XRT Alveo drivers
>      >>    fpga: xrt: driver metadata helper functions
>      >>    fpga: xrt: xclbin file helper functions
>      >>    fpga: xrt: xrt-lib driver manager
>      >>    fpga: xrt: group driver
>      >>    fpga: xrt: char dev node helper functions
>      >>    fpga: xrt: root driver infrastructure
>      >>    fpga: xrt: driver infrastructure
>      >>    fpga: xrt: management physical function driver (root)
>      >>    fpga: xrt: main driver for management function device
>      >>    fpga: xrt: fpga-mgr and region implementation for xclbin download
>      >>    fpga: xrt: VSEC driver
>      >>    fpga: xrt: User Clock Subsystem driver
>      >>    fpga: xrt: ICAP driver
>      >>    fpga: xrt: devctl xrt driver
>      >>    fpga: xrt: clock driver
>      >>    fpga: xrt: clock frequency counter driver
>      >>    fpga: xrt: DDR calibration driver
>      >>    fpga: xrt: partition isolation driver
>      >>    fpga: xrt: Kconfig and Makefile updates for XRT drivers
>      >>
>      >>   Documentation/fpga/index.rst                  |   1 +
>      >>   Documentation/fpga/xrt.rst                    | 870 ++++++++++++++++++
>      >>   MAINTAINERS                                   |  11 +
>      >>   drivers/Makefile                              |   1 +
>      >>   drivers/fpga/Kconfig                          |   2 +
>      >>   drivers/fpga/Makefile                         |   5 +
>      >>   drivers/fpga/xrt/Kconfig                      |   8 +
>      >>   drivers/fpga/xrt/include/events.h             |  45 +
>      >>   drivers/fpga/xrt/include/group.h              |  25 +
>      >>   drivers/fpga/xrt/include/metadata.h           | 236 +++++
>      >>   drivers/fpga/xrt/include/subdev_id.h          |  39 +
>      >>   drivers/fpga/xrt/include/xclbin-helper.h      |  48 +
>      >>   drivers/fpga/xrt/include/xdevice.h            | 131 +++
>      >>   drivers/fpga/xrt/include/xleaf.h              | 205 +++++
>      >>   drivers/fpga/xrt/include/xleaf/axigate.h      |  23 +
>      >>   drivers/fpga/xrt/include/xleaf/clkfreq.h      |  21 +
>      >>   drivers/fpga/xrt/include/xleaf/clock.h        |  29 +
>      >>   .../fpga/xrt/include/xleaf/ddr_calibration.h  |  28 +
>      >>   drivers/fpga/xrt/include/xleaf/devctl.h       |  40 +
>      >>   drivers/fpga/xrt/include/xleaf/icap.h         |  27 +
>      >>   drivers/fpga/xrt/include/xmgmt-main.h         |  34 +
>      >>   drivers/fpga/xrt/include/xroot.h              | 117 +++
>      >>   drivers/fpga/xrt/lib/Kconfig                  |  17 +
>      >>   drivers/fpga/xrt/lib/Makefile                 |  30 +
>      >>   drivers/fpga/xrt/lib/cdev.c                   | 209 +++++
>      >>   drivers/fpga/xrt/lib/group.c                  | 278 ++++++
>      >>   drivers/fpga/xrt/lib/lib-drv.c                | 328 +++++++
>      >>   drivers/fpga/xrt/lib/lib-drv.h                |  21 +
>      >>   drivers/fpga/xrt/lib/subdev.c                 | 859 +++++++++++++++++
>      >>   drivers/fpga/xrt/lib/subdev_pool.h            |  53 ++
>      >>   drivers/fpga/xrt/lib/xclbin.c                 | 381 ++++++++
>      >>   drivers/fpga/xrt/lib/xleaf/axigate.c          | 325 +++++++
>      >>   drivers/fpga/xrt/lib/xleaf/clkfreq.c          | 223 +++++
>      >>   drivers/fpga/xrt/lib/xleaf/clock.c            | 652 +++++++++++++
>      >>   drivers/fpga/xrt/lib/xleaf/ddr_calibration.c  | 210 +++++
>      >>   drivers/fpga/xrt/lib/xleaf/devctl.c           | 169 ++++
>      >>   drivers/fpga/xrt/lib/xleaf/icap.c             | 328 +++++++
>      >>   drivers/fpga/xrt/lib/xleaf/ucs.c              | 152 +++
>      >>   drivers/fpga/xrt/lib/xleaf/vsec.c             | 372 ++++++++
>      >>   drivers/fpga/xrt/lib/xroot.c                  | 536 +++++++++++
>      >>   drivers/fpga/xrt/metadata/Kconfig             |  12 +
>      >>   drivers/fpga/xrt/metadata/Makefile            |  16 +
>      >>   drivers/fpga/xrt/metadata/metadata.c          | 578 ++++++++++++
>      >>   drivers/fpga/xrt/mgmt/Kconfig                 |  15 +
>      >>   drivers/fpga/xrt/mgmt/Makefile                |  19 +
>      >>   drivers/fpga/xrt/mgmt/root.c                  | 420 +++++++++
>      >>   drivers/fpga/xrt/mgmt/xmgmt-main-region.c     | 483 ++++++++++
>      >>   drivers/fpga/xrt/mgmt/xmgmt-main.c            | 662 +++++++++++++
>      >>   drivers/fpga/xrt/mgmt/xmgmt.h                 |  33 +
>      >>   drivers/fpga/xrt/mgmt/xrt-mgr.c               | 190 ++++
>      >>   drivers/fpga/xrt/mgmt/xrt-mgr.h               |  16 +
>      >>   include/uapi/linux/xrt/xclbin.h               | 409 ++++++++
>      >>   include/uapi/linux/xrt/xmgmt-ioctl.h          |  46 +
>      >>   53 files changed, 9988 insertions(+)
>      >>   create mode 100644 Documentation/fpga/xrt.rst
>      >>   create mode 100644 drivers/fpga/xrt/Kconfig
>      >>   create mode 100644 drivers/fpga/xrt/include/events.h
>      >>   create mode 100644 drivers/fpga/xrt/include/group.h
>      >>   create mode 100644 drivers/fpga/xrt/include/metadata.h
>      >>   create mode 100644 drivers/fpga/xrt/include/subdev_id.h
>      >>   create mode 100644 drivers/fpga/xrt/include/xclbin-helper.h
>      >>   create mode 100644 drivers/fpga/xrt/include/xdevice.h
>      >>   create mode 100644 drivers/fpga/xrt/include/xleaf.h
>      >>   create mode 100644 drivers/fpga/xrt/include/xleaf/axigate.h
>      >>   create mode 100644 drivers/fpga/xrt/include/xleaf/clkfreq.h
>      >>   create mode 100644 drivers/fpga/xrt/include/xleaf/clock.h
>      >>   create mode 100644 drivers/fpga/xrt/include/xleaf/ddr_calibration.h
>      >>   create mode 100644 drivers/fpga/xrt/include/xleaf/devctl.h
>      >>   create mode 100644 drivers/fpga/xrt/include/xleaf/icap.h
>      >>   create mode 100644 drivers/fpga/xrt/include/xmgmt-main.h
>      >>   create mode 100644 drivers/fpga/xrt/include/xroot.h
>      >>   create mode 100644 drivers/fpga/xrt/lib/Kconfig
>      >>   create mode 100644 drivers/fpga/xrt/lib/Makefile
>      >>   create mode 100644 drivers/fpga/xrt/lib/cdev.c
>      >>   create mode 100644 drivers/fpga/xrt/lib/group.c
>      >>   create mode 100644 drivers/fpga/xrt/lib/lib-drv.c
>      >>   create mode 100644 drivers/fpga/xrt/lib/lib-drv.h
>      >>   create mode 100644 drivers/fpga/xrt/lib/subdev.c
>      >>   create mode 100644 drivers/fpga/xrt/lib/subdev_pool.h
>      >>   create mode 100644 drivers/fpga/xrt/lib/xclbin.c
>      >>   create mode 100644 drivers/fpga/xrt/lib/xleaf/axigate.c
>      >>   create mode 100644 drivers/fpga/xrt/lib/xleaf/clkfreq.c
>      >>   create mode 100644 drivers/fpga/xrt/lib/xleaf/clock.c
>      >>   create mode 100644 drivers/fpga/xrt/lib/xleaf/ddr_calibration.c
>      >>   create mode 100644 drivers/fpga/xrt/lib/xleaf/devctl.c
>      >>   create mode 100644 drivers/fpga/xrt/lib/xleaf/icap.c
>      >>   create mode 100644 drivers/fpga/xrt/lib/xleaf/ucs.c
>      >>   create mode 100644 drivers/fpga/xrt/lib/xleaf/vsec.c
>      >>   create mode 100644 drivers/fpga/xrt/lib/xroot.c
>      >>   create mode 100644 drivers/fpga/xrt/metadata/Kconfig
>      >>   create mode 100644 drivers/fpga/xrt/metadata/Makefile
>      >>   create mode 100644 drivers/fpga/xrt/metadata/metadata.c
>      >>   create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
>      >>   create mode 100644 drivers/fpga/xrt/mgmt/Makefile
>      >>   create mode 100644 drivers/fpga/xrt/mgmt/root.c
>      >>   create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-main-region.c
>      >>   create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-main.c
>      >>   create mode 100644 drivers/fpga/xrt/mgmt/xmgmt.h
>      >>   create mode 100644 drivers/fpga/xrt/mgmt/xrt-mgr.c
>      >>   create mode 100644 drivers/fpga/xrt/mgmt/xrt-mgr.h
>      >>   create mode 100644 include/uapi/linux/xrt/xclbin.h
>      >>   create mode 100644 include/uapi/linux/xrt/xmgmt-ioctl.h
>      >>
>
>

