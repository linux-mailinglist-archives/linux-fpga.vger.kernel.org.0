Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68FC5B4D2A
	for <lists+linux-fpga@lfdr.de>; Sun, 11 Sep 2022 12:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiIKKGw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Sep 2022 06:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiIKKGw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 11 Sep 2022 06:06:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1704013D7D;
        Sun, 11 Sep 2022 03:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662890811; x=1694426811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=COoydWrhxx4yHmAPhCBCqR8wvWQLCV4m7CypWvSwh8w=;
  b=d44lBWsFEfjgphwKGO7PfMVrzesBd1LZt5LIJ6qnTCcYcX0ut81SSd+b
   6CaU5fbEwGLbFjr4GOLKJAxtcCvdVj1zriaNTnaWMaBWSIKVBPtUxArwO
   EcBXVaO/lroMRTzLFscFkEmuV9NbxG+pXxeaZIBrWGzW41Uh5JaRiqXx5
   3O3Uhm9OAppnXmDjO4nqBw9zebfVOPFCjgROqfWeZagsPyTTwqg+AxDQQ
   LoMHNxJTUpOh9XrOMLs10ln82NA12pVTY0w3NfglpbVGCmm1pIp+cqm4r
   eE4HJOkQFt8Gd7zxGf1XEhgVzv/sNrP3AnMqmmsv47po6qRc1Q74aVGC7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="323936195"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="323936195"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 03:06:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="677732462"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 11 Sep 2022 03:06:46 -0700
Date:   Sun, 11 Sep 2022 17:57:15 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v1 1/5] Documentation: fpga: dfl: Add documentation for
 DFHv1
Message-ID: <Yx2w+yl9SFFx0Qtx@yilunxu-OptiPlex-7050>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
 <20220906190426.3139760-2-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906190426.3139760-2-matthew.gerlach@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-09-06 at 12:04:22 -0700, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add documentation describing the extentions provided by Version
> 1 of the Device Feature Header (DFHv1).
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  Documentation/fpga/dfl.rst | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 15b670926084..31699b89781e 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -561,6 +561,30 @@ new DFL feature via UIO direct access, its feature id should be added to the
>  driver's id_table.
>  
>  
> +Extending the Device Feature Header - DFHv1
> +===========================================
> +The current 8 bytes of the Device Feature Header, hereafter referred to as
> +to DFHv0, provide very little opportunity for the hardware to describe itself
> +to software. Version 1 of the Device Feature Header (DFHv1) is being introduced
> +to provide increased flexibility and extensibility to hardware designs using
> +Device Feature Lists.  The list below describes some of the goals behind the
> +changes in DFHv1:
> +
> +* Provide a standardized mechanism for features to describe
> +  parameters/capabilities to software.
> +* Standardize the use of a GUID for all DFHv1 types.
> +* Decouple the location of the DFH from the register space of the feature itself.
> +
> +Modeled after PCI Capabilities, DFHv1 Parameters provide a mechanism to associate
> +a list of parameter values to a particular feature.
> +
> +With DFHv0, not all features types contained a GUID.  DFHv1 makes the GUILD standard
> +across all types.
> +
> +With DFHv0, the register map of a given feature is located immediately following
> +the DFHv0 in the memory space.  With DFHv1, the location of the feature register
> +map can be specified as an offset to the DFHv1 or as an absolute address.

Could you make a table or diagram to describe the data structure layout of DFHv1
extention.

Thanks,
Yilun

> +
>  Open discussion
>  ===============
>  FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration
> -- 
> 2.25.1
> 
