Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2B14B4FF1
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Feb 2022 13:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242014AbiBNMTD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Feb 2022 07:19:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240786AbiBNMTB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Feb 2022 07:19:01 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B904927C;
        Mon, 14 Feb 2022 04:18:51 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id c5-20020a17090a1d0500b001b904a7046dso17164982pjd.1;
        Mon, 14 Feb 2022 04:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=b5GXTdaP8UX0YJthNdNaEYKkAqh83Ae4q4bpmeUiQzw=;
        b=dGPW5D3UIt/uWf+LBmxuvKR98tG6UdDlxSCLI3XzlS2nKEhup8fgNV9wwjmoLC69FB
         JxYbvvQ7o4qehj/2N0bnavkzoRVwtJs/zOGw0gTvK5QvMvYlIyUd/D/MJbz4YwZB2Bqb
         66hFarkNUyt5pg1C7Pc2S6FfnLrdVT2Rb1SgQ25WCIWB1b0lxvITooHBRiYBQv95l0pa
         TEp2Y+sVwWptMj0Bdbb3fw8K5a/YTFhQjm3CJWWIjZDBcjCNONJ7+vpw9AtD7jmlWG+d
         vTnorqmAP0SJD7kPVI+8ZtnObwlD3mtp1xNCoo7b2hbMqIsvToni51IDo2CkP9yvvzUd
         peiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=b5GXTdaP8UX0YJthNdNaEYKkAqh83Ae4q4bpmeUiQzw=;
        b=EAMsPVKrpWaxERzy/XBYkgRaM6sfuLMtlwlBo9wYoXSdzo8Ec6N2vliIzt73F/L4hg
         gNYykqBOVQpUpooQgbXmcAe6y6kl7rcXlpO1fTgDmngxYLm5YzkNiIbEX0I8/qOhP/VO
         Hi3ok3H+/zYAuf6rHART9Ng6wSBv6ldHRaj3VnFAtBb26O6Vi1+K5pY8k0tV9yNTbyG2
         xf4VAegMKExDogtsRQ479Qa5umxQtadz94+axxxXMISNfS25BR2LydxJOezFG6H/pvi3
         V0WoUmY8HivT2n/iiw98iTOd5lJ7CqYf381SV4P+hNIpHHa2Xy2KzLytLBYHyx2Ti3OM
         0SNw==
X-Gm-Message-State: AOAM53091GR1Ut12dW36XnjfbaZvtUpl78schAWbWXTicaxmUeI3JwmU
        QZhYweYa4/8vexobiss+eMs=
X-Google-Smtp-Source: ABdhPJx9RKokcJ0iyIkWa7wex5gmBAFb7KBQRNWClm3nzMLErCgC1ZoDq1Y/IXf3yhTn4YBKSYi9pw==
X-Received: by 2002:a17:90a:de10:: with SMTP id m16mr14135317pjv.157.1644841130490;
        Mon, 14 Feb 2022 04:18:50 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id v20sm13818402pju.9.2022.02.14.04.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 04:18:50 -0800 (PST)
Message-ID: <eb5506aa-815d-b373-2eff-a3b9df533141@gmail.com>
Date:   Mon, 14 Feb 2022 21:18:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
To:     Tianfei zhang <tianfei.zhang@intel.com>
Cc:     corbet@lwn.net, hao.wu@intel.com, linux-doc@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, trix@redhat.com, yilun.xu@intel.com,
        Akira Yokosawa <akiyks@gmail.com>
References: <20220214112619.219761-2-tianfei.zhang@intel.com>
Subject: Re: [PATCH v1 1/7] Documentation: fpga: dfl: add description of IOFS
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20220214112619.219761-2-tianfei.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi,

Just a couple of nits on ReST formatting.

On Mon, 14 Feb 2022 06:26:13 -0500,
Tianfei zhang <tianfei.zhang@intel.com> wrote:
> From: Tianfei Zhang <tianfei.zhang@intel.com>
> 
> This patch adds description about IOFS support for DFL.
> 
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>  Documentation/fpga/dfl.rst | 99 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index ef9eec71f6f3..6f9eae1c1697 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -58,7 +58,10 @@ interface to FPGA, e.g. the FPGA Management Engine (FME) and Port (more
>  descriptions on FME and Port in later sections).
>  
>  Accelerated Function Unit (AFU) represents an FPGA programmable region and
> -always connects to a FIU (e.g. a Port) as its child as illustrated above.
> +always connects to a FIU (e.g. a Port) as its child as illustrated above, but
> +on IOFS design, it introducing Port Gasket which contains AFUs. For DFL perspective,
> +the Next_AFU pointer on FIU feature header can point to NULL so the AFU is not
> +connects to a FIU(more descriptions on IOFS in later section).
>  
>  Private Features represent sub features of the FIU and AFU. They could be
>  various function blocks with different IDs, but all private features which
> @@ -134,6 +137,9 @@ reconfigurable region containing an AFU. It controls the communication from SW
>  to the accelerator and exposes features such as reset and debug. Each FPGA
>  device may have more than one port, but always one AFU per port.
>  
> +On IOFS, it introducing a new hardware unit, Port Gasket, which contains all
> +the PR specific modules and regions (more descriptions on IOFS in later section).
> +
>  
>  AFU
>  ===
> @@ -143,6 +149,9 @@ used for accelerator-specific control registers.
>  User-space applications can acquire exclusive access to an AFU attached to a
>  port by using open() on the port device node and release it using close().
>  
> +On IOFS, the AFU is embedded in a Port Gasket. The AFU resource can expose via
> +VFs with SRIOV support (more descriptions on IOFS in later section).
> +
>  The following functions are exposed through ioctls:
>  
>  - Get driver API version (DFL_FPGA_GET_API_VERSION)
> @@ -284,7 +293,8 @@ FME is always accessed through the physical function (PF).
>  
>  Ports (and related AFUs) are accessed via PF by default, but could be exposed
>  through virtual function (VF) devices via PCIe SRIOV. Each VF only contains
> -1 Port and 1 AFU for isolation. Users could assign individual VFs (accelerators)
> +1 Port (On IOFS design, the VF is designs without Port) and 1 AFU for isolation.
> +Users could assign individual VFs (accelerators)
>  created via PCIe SRIOV interface, to virtual machines.
>  
>  The driver organization in virtualization case is illustrated below:
> @@ -389,6 +399,91 @@ The device nodes used for ioctl() or mmap() can be referenced through::
>  	/sys/class/fpga_region/<regionX>/<dfl-fme.n>/dev
>  	/sys/class/fpga_region/<regionX>/<dfl-port.n>/dev
>  
> +Intel Open FPGA stack
> +=====================

Here you need an empty line.

> +Intel Open FPGA stack aka IOFS, Intel's version of a common core set of
> +RTL to allow customers to easily interface to logic and IP on the FPGA.
> +IOFS leverage the DFL for the implementation of the FPGA RTL design.
> +
> +IOFS designs allow for the arrangement of software interfaces across multiple
> +PCIe endpoints. Some of these interfaces may be PFs defined in the static region
> +that connect to interfaces in an IP that is loaded via Partial Reconfiguration (PR).
> +And some of these interfaces may be VFs defined in the PR region that can be
> +reconfigured by the end-user. Furthermore, these PFs/VFs may also be arranged
> +using a DFL such that features may be discovered and accessed in user space
> +(with the aid of a generic kernel driver like vfio-pci). The diagram below depicts
> +an example design with two PFs and two VFs. In this example, PF1 implements its
> +MMIO space such that it is compatible with the VirtIO framework. The other functions,
> +VF0 and VF1, leverage VFIO to export the MMIO space to an application or a hypervisor.
> +
For an ASCII-art to be recognized as such, you need a leading "::" here.

   ::

> +     +-----------------+  +--------------+  +-------------+  +------------+
> +     | FPGA Managerment|  |   VirtIO     |  |  User App   |  | Virtual    |
> +     |      App        |  |     App      |  |             |  | Machine    |
> +     +--------+--------+  +------+-------+  +------+------+  +-----+------+
> +              |                  |                 |               |
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
> +On IOFS, it introducing some enhancements compared with original DFL design.
Again, you need an empty line here.

> +1. It introducing Port Gasket in PF0 which is responsible for FPGA management,
> +like FME and Port management. The Port Gasket contains all the PR specific modules
> +and logic, e.g., PR slot reset/freeze control, user clock, remote STP etc.
> +Architecturally, a Port Gasket can have multiple PR slots where user workload can
> +be programmed into.
> +2. To expend the scalable of FPGA, it can support multiple FPs in static region
> +which contain some static functions like VirtIO, diagnostic test, and access over
> +VFIO or assigned to VMs easily. Those PFs will not have a Port Unit which without
> +PR region (AFU) connected to those PFs, and the end-user cannot partial reconfigurate
> +those PFs.
> +3. In our previous DFL design, it can only create one VF based in an AFU. To raise
> +the efficiency usage of AFU, it can create more than one VFs in an AFU via PCIe
> +SRIOV, so those VFs share the PR region and resource.

This enumeration list needs some indent tweaks.

1. It introducing Port Gasket in PF0 which is responsible for FPGA management,
   like FME and Port management. The Port Gasket contains all the PR specific modules
   and logic, e.g., PR slot reset/freeze control, user clock, remote STP etc.
   Architecturally, a Port Gasket can have multiple PR slots where user workload can
   be programmed into.
2. To expend the scalable of FPGA, it can support multiple FPs in static region
   which contain some static functions like VirtIO, diagnostic test, and access over
   VFIO or assigned to VMs easily. Those PFs will not have a Port Unit which without
   PR region (AFU) connected to those PFs, and the end-user cannot partial reconfigurate
   those PFs.
3. In our previous DFL design, it can only create one VF based in an AFU. To raise
   the efficiency usage of AFU, it can create more than one VFs in an AFU via PCIe
   SRIOV, so those VFs share the PR region and resource.

> +
> +There is one reference architecture design for IOFS as illustrated below:
                                                                           ::

(This "::" can also lead an ASCII-art.)

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
> +    +-------+       +----------+    +--------+   | |
> +    | Port  |            PF1            PF2      | |
> +    +---+---+                                    | |
> +        |                             +----------+ |
> +        |                             |           ++
> +        |                             |           |
> +        |                             | PF0_VF0   | PF0_VF1
> +        |           +-----------------+-----------+------------+
> +        |           |           +-----+-----------+--------+   |
> +        |           |           |     |           |        |   |
> +        |           | +------+  |  +--+ -+     +--+---+    |   |
> +        |           | | CSR  |  |  | DFH |     |  DFH |    |   |
> +        +-----------+ +------+  |  +-----+     +------+    |   |
> +                    |           |  | DEV |     |  DEV |    |   |
> +                    |           |  +-----+     +------+    |   |
> +                    |           |            PR Slot       |   |
> +                    |           +--------------------------+   |
> +                    | Port Gasket                              |
> +                    +------------------------------------------+
> +
> +Here are the major changes about DFL structures on IOFS implementation design:
Again, you need an empty line.

> +1. The Port Gasket connects to FIU Port in DFL, but the Next_AFU pointer in
> +FIU feature header can point to NULL so that it is no AFU connects to a FIU
> +Port.
> +2. The VF which include in PR region can start with AFU feature header without
> +a FIU Port feature header.

As above, this list should look:

1. The Port Gasket connects to FIU Port in DFL, but the Next_AFU pointer in
   FIU feature header can point to NULL so that it is no AFU connects to a FIU
   Port.
2. The VF which include in PR region can start with AFU feature header without
   a FIU Port feature header.

>  
>  Performance Counters
>  ====================
> -- 
> 2.17.1

I'd recommend running "make htmdocs" and see if the pages are rendered as you
expect.

        Thanks, Akira

