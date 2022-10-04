Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE11F5F463D
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Oct 2022 17:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiJDPLR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Oct 2022 11:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiJDPLQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Oct 2022 11:11:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D595C972;
        Tue,  4 Oct 2022 08:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664896275; x=1696432275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jt1zhhzWQPCIb7s+F2K8oafIF8qJn4glsLc79dMHHZg=;
  b=CbnBSR4YOkhcEZmMEsflH6RWIbwXDDf6iuK6vr0Lsfiz/sFmKuLbeoIn
   RT4ZnVXC/2/Yy/JZJs1fVqLA1yIjS3X7mwxtt7Kbkq21wsuYL6R5EUGVI
   8uHnq1hgV2hwB7t2/7F1dNp0JRsNDw7UCJEc82OtfqsLUCydQkTMmrHLt
   H+V43wVvDbm+ncddjjtMHafRDWa9tJ6q4Cs1nzr2sGasIyE2y/lQg7U6l
   esWPnlMNlqTn2AcP+gCqvnTTBB9DlNOqhHNddxJ4bcu0sTcSDMbjFBTpI
   P0SEgxykD0P2ML1AGOhUSWini4I4cmjVAp/+4lz+3g3jl3tsee8NGunyU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="303895587"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="303895587"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 08:11:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="749397876"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="749397876"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 04 Oct 2022 08:11:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ofjZb-0027pM-07;
        Tue, 04 Oct 2022 18:11:07 +0300
Date:   Tue, 4 Oct 2022 18:11:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v3 3/4] fpga: dfl: add basic support for DFHv1
Message-ID: <YzxNCngIuzMqIOHe@smile.fi.intel.com>
References: <20221004143718.1076710-1-matthew.gerlach@linux.intel.com>
 <20221004143718.1076710-4-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004143718.1076710-4-matthew.gerlach@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Oct 04, 2022 at 07:37:17AM -0700, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add generic support for MSIX interrupts for DFL devices.

$ git grep -n -w MSI[xX] | wc -l
421

$ git grep -n -w MSI-[xX] | wc -l
1224

MSI-X (This is I believe the official name for that)

And everywhere.

> The location of a feature's registers is explicitly
> described in DFHv1 and can be relative to the base of the DFHv1
> or an absolute address.  Parse the location and pass the information
> to DFL driver.

...

> +	ddev->csr_res.start = feature->csr_res.start;
> +	ddev->csr_res.end = feature->csr_res.end;
> +	ddev->csr_res.flags = IORESOURCE_MEM;

Why simple assignment of the resource can't work?

	ddev->csr_res = feature->csr_res;

(I know the downside of this, but still)

...

> +		feature->csr_res.start = finfo->csr_res.start;
> +		feature->csr_res.end = finfo->csr_res.end;

Ditto.

...

> +	case 0:
> +		type = feature_dev_id_type(binfo->feature_dev);
> +		if (type == PORT_ID) {
> +			switch (fid) {
> +			case PORT_FEATURE_ID_UINT:
> +				v = readq(base + PORT_UINT_CAP);
> +				ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> +				inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> +				break;
> +			case PORT_FEATURE_ID_ERROR:
> +				v = readq(base + PORT_ERROR_CAP);
> +				ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> +				inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> +				break;

No default?

> +			}
> +		} else if (type == FME_ID) {

> +			if (fid == FME_FEATURE_ID_GLOBAL_ERR) {

Don't remember if that was discussed already or not, but

I would use switch-case here as well in order to be consistent with the
previous code piece pattern.

> +				v = readq(base + FME_ERROR_CAP);
> +				ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> +				inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> +			}
> +		}
> +		break;

...

> +		if (v & DFHv1_CSR_ADDR_REL)
> +			finfo->csr_res.start = FIELD_GET(DFHv1_CSR_ADDR_MASK, v);
> +		else
> +			finfo->csr_res.start = binfo->start + ofst
> +					       + FIELD_GET(DFHv1_CSR_ADDR_MASK, v);

Locate + on the previous line.

> +		v = readq(binfo->ioaddr + ofst + DFHv1_CSR_SIZE_GRP);
> +		finfo->csr_res.end = finfo->csr_res.start
> +				     + FIELD_GET(DFHv1_CSR_SIZE_GRP_SIZE, v) - 1;

Ditto.

...

> +int dfhv1_find_param(void __iomem *base, resource_size_t max, int param)
> +{
> +	int off = DFHv1_PARAM_HDR;
> +	u64 v, next;
> +
> +	while (off < max) {
> +		v = readq(base + off);
> +		if (param == FIELD_GET(DFHv1_PARAM_HDR_ID, v))

> +			return (DFHv1_PARAM_DATA + off);

Too many parentheses.

> +
> +		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
> +		if (!next)
> +			break;
> +
> +		off += next;
> +	}
> +
> +	return -ENOENT;
> +}

The entire function seems a bit dangerous to me. You can ask for any max which
covers (up to) 64-bit address space and then do MMIO by basically arbitrary
address. How do you protect against wrong MMIO window here? (This is FPGA, so
anything can be read from HW, i.o.w. it's _untrusted_ source of the data.)

Also, have you tested this with IOMMU enabled? How do they work together (if
there is any collision at all between two?)

...

> +int dfhv1_find_param(void __iomem *base, resource_size_t max, int param);

> +int dfhv1_has_params(void __iomem *base);

I would expect to see some struct instead of base which will provide means of
protection against wrong MMIO accesses.

...

Kernel doc usually accompanies the C-code, i.o.w. implementations and not
declarations.

-- 
With Best Regards,
Andy Shevchenko


