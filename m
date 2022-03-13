Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD0D4D76CF
	for <lists+linux-fpga@lfdr.de>; Sun, 13 Mar 2022 17:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbiCMQdc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 13 Mar 2022 12:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiCMQdc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 13 Mar 2022 12:33:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949D439152;
        Sun, 13 Mar 2022 09:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=SM6PPsTfSXfbqVR394vJi3lq5mivuWcHSnVofR/mQuw=; b=Mv1uAqahod5abfM19k806udL97
        is+ssxpZlpQmvSKDXByzr/cJlZT3FFk/cA2e9/UtiArNWtbvpOd24ULb1f5DhA61PbWuLZw8Z8Cw3
        qTzlWS8HSuYbmgTT/cF/l9UUV0mIsILExtqUN8xETtKL4L2niRv/7RCaBsZlk8iU4hKwVTpqVWKBg
        dohjZ40IO6FSqJS81i14JaEDXpKozorve3iuuHMleKdJCv6cdbjPQE8nlJRWX7fCx/VDMhZ8WbSe1
        5nRNlokMROYJrZCH4YqN9VNOUvhuztdoj+usj/qGJXK2HdwBLL9mPkWMnjw0eJ+W0Fg5iGI6s1EVp
        gmA43+fg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTR8e-003KhS-Pl; Sun, 13 Mar 2022 16:32:13 +0000
Message-ID: <a5631765-5a38-3875-781c-8acc5fc8e896@infradead.org>
Date:   Sun, 13 Mar 2022 09:32:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 6/6] Documentation: fpga: dfl: add description of OFS
Content-Language: en-US
To:     Tianfei Zhang <tianfei.zhang@intel.com>, hao.wu@intel.com,
        trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net
References: <20220313105242.1567774-1-tianfei.zhang@intel.com>
 <20220313105242.1567774-7-tianfei.zhang@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220313105242.1567774-7-tianfei.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi--

On 3/13/22 03:52, Tianfei Zhang wrote:
> From: Tianfei zhang <tianfei.zhang@intel.com>
> 
> This patch adds description about OFS support for DFL.
> 
> ---
> v5:
> fix documentation with Matthew and Randy's comment.
> v4:
> add description about access the AFU on "multiple VFs per PR slot" model.
> v3:
> change IOFS to OFS in documentation.
> v2:
> * Fixs some typos.
> * Adds more detail description about the models of AFU access which supported in OFS.
> 
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> ---
>  Documentation/fpga/dfl.rst | 114 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 114 insertions(+)
> 
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index ef9eec71f6f3..4c1f9cb82ccb 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -556,6 +556,120 @@ new DFL feature via UIO direct access, its feature id should be added to the
>  driver's id_table.
>  
>  
> +Open FPGA Stack
> +=====================
> +
> +Open FPGA Stack (OFS) is a collection of RTL and open source software providing
> +interfaces to access the instantiated RTL easily in an FPGA. OFS leverages the
> +DFL for the implementation of the FPGA RTL design.
> +
> +OFS designs allow for the arrangement of software interfaces across multiple
> +PCIe endpoints. Some of these interfaces may be PFs defined in the static region
> +that connect to interfaces in an IP that is loaded via Partial Reconfiguration (PR).
> +And some of these interfaces may be VFs defined in the PR region that can be
> +reconfigured by the end-user. Furthermore, these PFs/VFs may use DFLs such that
> +features may be discovered and accessed in user space (with the aid of a generic
> +kernel driver like vfio-pci). The diagram below depicts an example design with two
> +PFs and two VFs. In this example, it will export the management functions via PF0,
> +PF1 will bind with virtio-net driver presenting itself as a network interface to
> +the OS. The other functions, VF0 and VF1, leverage VFIO to export the MMIO space
> +to an application or assign to a VM.
> +::
> +
> +     +-----------------+  +--------------+  +-------------+  +------------+
> +     | FPGA Management |  |   VirtIO     |  |  User App   |  | Virtual    |
> +     |      App        |  |     App      |  |             |  | Machine    |
> +     +--------+--------+  +------+-------+  +------+------+  +-----+------+
> +              |                  |                 |               |
> +     +--------+--------+  +------+-------+  +------+------+        |
> +     |     DFL Driver  |  |VirtIO driver |  |    VFIO     |        |
> +     +--------+--------+  +------+-------+  +------+------+        |
> +              |                  |                 |               |
> +              |                  |                 |               |
> +     +--------+--------+  +------+-------+  +------+------+   +----+------+
> +     |     PF0         |  |     PF1      |  |   PF0_VF0   |   |  PF0_VF1  |
> +     +-----------------+  +--------------+  +-------------+   +-----------+
> +
> +As accelerators are specialized hardware, they are typically limited in the
> +number installed in a given system. Many use cases require them to be shared
> +across multiple software contexts or threads of software execution, either
> +through partitioning of individual dedicated resources, or virtualization of
> +shared resources. OFS provides several models to share the AFU resources via
> +PR mechanism and hardware-based virtualization schemes.
> +
> +1. Legacy model.
> +   With legacy model FPGA cards like Intel PAC N3000 or N5000,there is

Add a space after the comma.

> +   a notion that the boundary between the AFU and the shell is also the unit of
> +   PR for those FPGA platforms. This model can only able to handle a

                                   This model is only able to handle a

> +   single context, because it only has one PR engine, and one PR region which
> +   has an associated Port device.
> +2. Multiple VFs per PR slot.
> +   In this model, available AFU resources may allow instantiation of many of VFs

                                                                     of many VFs

> +   which has a dedicated PCIe function with their own dedicated MMIO space, or

      which have

or something different. I couldn't quite tell what is meant here.

> +   partition a region of MMIO space on a single PCIe function. Intel PAC N6000
> +   card has implemented this model.
> +   In this model, the AFU/PR slot was not connected to port device. For DFL's view,
> +   the Next_AFU pointer in FIU feature header of port device points to NULL in this
> +   model, so in AFU driver perspective, there are no AFU MMIO region managed by

                                           there is no

> +   AFU driver. On the other hand, each VF can start with an AFU feature header without
> +   connected to a FIU Port feature header.

      being connected
or
      connecting

> +
> +In multiple VFs per PR slot model, the port device can still be accessed using
> +ioctls API which expose by /dev/dfl-port.n device node, like port reset, get

              which expose /dev/dfl-port.h device nodes,

> +port info, whose APIs were mentioned in AFU section in this documentation. But
> +it cannot access the AFU MMIO space via AFU ioctl APIs like DFL_FPGA_PORT_DMA_MAP
> +because no AFU MMIO space managed in AFU driver. Users can access the AFU resource

   because there is no AFU MMIO space managed in the AFU driver.

> +by creating VF devices via PCIe SRIOV interface, and then access the VF via VFIO
> +driver or assign the VF to VM.
> +
> +In multiple VFs per PR slot model, the steps enable VFs are compatible with

                                                to enable VFs

> +legacy mode which mentioned in "FPGA virtualization - PCIe SRIOV" section

               which are mentioned

> +in this documentation.
> +
> +OFS provides the diversity for access the AFU resource to RTL developer.

                              for accessing the AFU resource

> +An IP designer may choose to add more than one PF for interfacing with IP
> +on the FPGA and choose different model to access the AFU resource.
> +
> +There is one reference architecture design using the "Multiple VFs per PR slot"
> +model for OFS as illustrated below. In this reference design, it exports the
> +FPGA management functions via PF0. PF1 will bind with virtio-net driver
> +presenting itself as a network interface to the OS. PF2 will bound to the

                                                                bind

> +vfio-pci driver allowing the user space software to discover and interface
> +with the specific workload like diagnostic test. To access the AFU resource,
> +it uses SR-IOV to partition workload interfaces across various VFs.
> +::
> +
> +                              +----------------------+
> +                              |   PF/VF mux/demux    |
> +                              +--+--+-----+------+-+-+
> +                                 |  |     |      | |
> +        +------------------------+  |     |      | |
> +  PF0   |                 +---------+   +-+      | |
> +    +---+---+             |         +---+----+   | |
> +    |  DFH  |             |         |   DFH  |   | |
> +    +-------+       +-----+----+    +--------+   | |
> +    |  FME  |       |  VirtIO  |    |  Test  |   | |
> +    +---+---+       +----------+    +--------+   | |
> +        |                PF1            PF2      | |
> +        |                                        | |
> +        |                             +----------+ |
> +        |                             |           ++
> +        |                             |           |
> +        |                             | PF0_VF0   | PF0_VF1
> +        |           +-----------------+-----------+------------+
> +        |           |           +-----+-----------+--------+   |
> +        |           |           |     |           |        |   |
> +        |           | +------+  |  +--+ -+     +--+---+    |   |
> +        |           | | Port |  |  | DFH |     |  DFH |    |   |
> +        +-----------+ +------+  |  +-----+     +------+    |   |
> +                    |           |  | DEV |     |  DEV |    |   |
> +                    |           |  +-----+     +------+    |   |
> +                    |           |            PR Slot       |   |
> +                    |           +--------------------------+   |
> +                    | Port Gasket                              |
> +                    +------------------------------------------+
> +
> +
>  Open discussion
>  ===============
>  FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration

-- 
~Randy
