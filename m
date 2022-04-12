Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF8A4FE58A
	for <lists+linux-fpga@lfdr.de>; Tue, 12 Apr 2022 18:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357488AbiDLQIr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 12 Apr 2022 12:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbiDLQIq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 12 Apr 2022 12:08:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F34522FE;
        Tue, 12 Apr 2022 09:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649779588; x=1681315588;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zVz0ndJcjNLE4BQ9ppejmWERpHKseHaeuzA2yYxgTfw=;
  b=R0kqIdHS0y1vXG3kwRAsQZBk1cq4z98PwdXQ3Cclpmh4XOGDaa//eD1n
   T/DKR/Q/5E5UjXAFVoHLQlrCmNTVM3lW8uL1b9jJsnGh17tgOKooTtibN
   ZaMOKSt7f0ZPZ7pXC9p+MvH6S1el6l62oByvvp8wZIgRv6wv9SgLhj9oi
   lkJfsRkjr96zEOaNFGjJc8McbDyziSFDkqW/KD2vkK2Xx2rq4NTjThYh6
   qf7K2tg26yn8Aoi7po/CcloRJNKQd3BuhPGouarFCedNhtMENejw6DtuR
   gILBfYB2l4KA/Gw9V/B2yNBuLd/RijXlxe0c781h2f9sFSorZygdgvoUK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="260006383"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="260006383"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 09:03:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="551769856"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 09:03:49 -0700
Date:   Tue, 12 Apr 2022 09:05:51 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Tianfei Zhang <tianfei.zhang@intel.com>
cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, rdunlap@infradead.org, corbet@lwn.net
Subject: Re: [PATCH v6 1/2] fpga: dfl: check feature type before parse irq
 info
In-Reply-To: <20220412061705.53721-2-tianfei.zhang@intel.com>
Message-ID: <alpine.DEB.2.22.394.2204120903100.278492@rhweight-WRK1>
References: <20220412061705.53721-1-tianfei.zhang@intel.com> <20220412061705.53721-2-tianfei.zhang@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Tue, 12 Apr 2022, Tianfei Zhang wrote:

> From: Tianfei zhang <tianfei.zhang@intel.com>
>
> Previously the feature IDs defined are unique, no matter
> which feature type. But currently we want to extend its
> usage to have a per-type feature ID space, so this patch
> adds feature type checking as well just before look into
> feature ID for different features which have irq info.
>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>

Hi Tienfei,

I reviewed you v5 version.  You may add the following tag:

Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>

> ---
> v4:
>  - Fix the git commit from Hao's comments.
>  - Split documentation into another patch.
> v3:
>  - Remove "Fixes" in commit log with Hao's comment, this is a
>    extension not a bug fix.
> v2:
>  - add DFL Feature ID Registry in documentation.
> ---
> drivers/fpga/dfl.c | 38 ++++++++++++++++++++++----------------
> 1 file changed, 22 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 599bb21d86af..6bff39ff21a0 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -940,9 +940,12 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
> {
> 	void __iomem *base = binfo->ioaddr + ofst;
> 	unsigned int i, ibase, inr = 0;
> +	enum dfl_id_type type;
> 	int virq;
> 	u64 v;
>
> +	type = feature_dev_id_type(binfo->feature_dev);
> +
> 	/*
> 	 * Ideally DFL framework should only read info from DFL header, but
> 	 * current version DFL only provides mmio resources information for
> @@ -957,22 +960,25 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
> 	 * code will be added. But in order to be compatible to old version
> 	 * DFL, the driver may still fall back to these quirks.
> 	 */
> -	switch (fid) {
> -	case PORT_FEATURE_ID_UINT:
> -		v = readq(base + PORT_UINT_CAP);
> -		ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> -		inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> -		break;
> -	case PORT_FEATURE_ID_ERROR:
> -		v = readq(base + PORT_ERROR_CAP);
> -		ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> -		inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> -		break;
> -	case FME_FEATURE_ID_GLOBAL_ERR:
> -		v = readq(base + FME_ERROR_CAP);
> -		ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> -		inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> -		break;
> +	if (type == PORT_ID) {
> +		switch (fid) {
> +		case PORT_FEATURE_ID_UINT:
> +			v = readq(base + PORT_UINT_CAP);
> +			ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> +			inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> +			break;
> +		case PORT_FEATURE_ID_ERROR:
> +			v = readq(base + PORT_ERROR_CAP);
> +			ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> +			inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> +			break;
> +		}
> +	} else if (type == FME_ID) {
> +		if (fid == FME_FEATURE_ID_GLOBAL_ERR) {
> +			v = readq(base + FME_ERROR_CAP);
> +			ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> +			inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> +		}
> 	}
>
> 	if (!inr) {
> -- 
> 2.26.2
>
>
