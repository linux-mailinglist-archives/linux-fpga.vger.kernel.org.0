Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276C95E7CB7
	for <lists+linux-fpga@lfdr.de>; Fri, 23 Sep 2022 16:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiIWOQv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 23 Sep 2022 10:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbiIWOQs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 23 Sep 2022 10:16:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16965122A78;
        Fri, 23 Sep 2022 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663942607; x=1695478607;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YxdtYMXoEwBQTvm4QHgP6aL9/JiSU6i4piy+cSeCJ7E=;
  b=LWzpU+VI6IMnQT4IcXSHPKverXEY/vIX2jXZA+SxHJ+wVc2pcuvlqk8J
   jp2qI9YrC+ESxUuNp9Qt2hhMC1Bg57WTLeCV6ByPUOD+osKS05r6B9bb+
   k3g558GE8t98R4Si/LZSj1jvz2EpcpbGPiA4OLuidO5+sQaczg4I1mlko
   XDcdqWVs7ByxKF4RrJPGSv3rPR7mSJcOIwCmHn/7AMiN3wS6ZIrbriWro
   8pBXxo/p57M/tdAjRTKUK1CZn2YcapdXExFs4LtoZiTV2ECYvS93GKB7r
   /tVATWBxb3E/JR4EwjoCqRU+o9Z4SyR2cKbckxHrbw5wFxOt24OVoBot0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="300583472"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="300583472"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 07:16:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="653412626"
Received: from alutz-mobl.ger.corp.intel.com ([10.252.35.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 07:16:40 -0700
Date:   Fri, 23 Sep 2022 17:16:38 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tianfei.zhang@intel.com, corbet@lwn.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, geert+renesas@glider.be,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 4/6] fpga: dfl: add generic support for MSIX
 interrupts
In-Reply-To: <20220923121745.129167-5-matthew.gerlach@linux.intel.com>
Message-ID: <a602677-78ac-23a0-1a63-96b325595998@linux.intel.com>
References: <20220923121745.129167-1-matthew.gerlach@linux.intel.com> <20220923121745.129167-5-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, 23 Sep 2022, matthew.gerlach@linux.intel.com wrote:

> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Define and use a DFHv1 parameter to add generic support for MSIX
> interrupts for DFL devices.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v2: fix kernel doc
>     clarify use of DFH_VERSION field
> ---
>  drivers/fpga/dfl.c  | 60 +++++++++++++++++++++++++++++++++++++++++----
>  include/linux/dfl.h | 14 +++++++++++
>  2 files changed, 69 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 1132f3c10440..dfd3f563c92d 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -941,23 +941,22 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>  	void __iomem *base = binfo->ioaddr + ofst;
>  	unsigned int i, ibase, inr = 0;
>  	enum dfl_id_type type;
> -	int virq;
> +	int virq, off;
>  	u64 v;
>  
>  	type = feature_dev_id_type(binfo->feature_dev);
>  
>  	/*
>  	 * Ideally DFL framework should only read info from DFL header, but
> -	 * current version DFL only provides mmio resources information for
> +	 * current version, DFHv0, only provides mmio resources information for
>  	 * each feature in DFL Header, no field for interrupt resources.
>  	 * Interrupt resource information is provided by specific mmio
>  	 * registers of each private feature which supports interrupt. So in
>  	 * order to parse and assign irq resources, DFL framework has to look
>  	 * into specific capability registers of these private features.
>  	 *
> -	 * Once future DFL version supports generic interrupt resource
> -	 * information in common DFL headers, the generic interrupt parsing
> -	 * code will be added. But in order to be compatible to old version
> +	 * DFHv1 supports generic interrupt resource information in DFHv1
> +	 * parameter blocks. But in order to be compatible to old version
>  	 * DFL, the driver may still fall back to these quirks.
>  	 */
>  	if (type == PORT_ID) {
> @@ -981,6 +980,36 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>  		}
>  	}
>  
> +	if (fid != FEATURE_ID_AFU && fid != PORT_FEATURE_ID_ERROR &&
> +	    fid != PORT_FEATURE_ID_UINT && fid != FME_FEATURE_ID_GLOBAL_ERR) {
> +
> +		v = FIELD_GET(DFH_VERSION, readq(base));

I'd call this variable version (or ver) if you want to store it but it 
would also fit to switch () line so that no extra variable is needed.

> +		switch (v) {
> +		case 0:
> +			break;
> +
> +		case 1:
> +			v =  readq(base + DFHv1_CSR_SIZE_GRP);

Extra space.

> +			if (FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS, v)) {
> +				off = dfl_find_param(base + DFHv1_PARAM_HDR, ofst,
> +						     DFHv1_PARAM_ID_MSIX);
> +				if (off >= 0) {

I'd reverse these 2 conditions and break when there's nothing to do.

> +					ibase = readl(base + DFHv1_PARAM_HDR +
> +						      off + DFHv1_PARAM_MSIX_STARTV);
> +					inr = readl(base + DFHv1_PARAM_HDR +
> +						    off + DFHv1_PARAM_MSIX_NUMV);
> +					dev_dbg(binfo->dev, "start %d num %d fid 0x%x\n",
> +						ibase, inr, fid);
> +				}
> +			}
> +			break;
> +
> +		default:
> +			dev_warn(binfo->dev, "unexpected DFH version %lld\n", v);
> +			break;
> +		}
> +	}
> +
>  	if (!inr) {
>  		*irq_base = 0;
>  		*nr_irqs = 0;

-- 
 i.

