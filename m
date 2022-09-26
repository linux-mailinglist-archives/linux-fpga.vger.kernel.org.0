Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DEF5EAC6C
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Sep 2022 18:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbiIZQYU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 26 Sep 2022 12:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbiIZQYC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 26 Sep 2022 12:24:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB6EFE64F;
        Mon, 26 Sep 2022 08:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664205172; x=1695741172;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DdnFEf3Z9EiRRHykbZYmRviWkWZkPGSza/2gJffcK00=;
  b=legMk3/mh2fDpYFBJ/uK4VY3CWV8U0yeSlkbqFF62Eq6v4au2naPCGAw
   tDzNEsnscPUlRkhsYecJSjZUwtqNV7fF08t+l9VDH5Cd5lMtK3U9lAIMl
   sbXx1bAeqMXjX9oovMhgPfKfmR/6l5vL87cF9HoHkMLFZLBZdIoHWJ2jb
   RZFwrSA/hk0D6+1ml9RGDk+PiQz5nZL3W1G1QHj5R8PargdSSuxf5Jfc6
   DAEqgYni9HPY25ArgtL1RsItk9PfUEM3MXyAp7vsFpbaEhGzuCJXIHMCO
   tBJDhPbBySipKhQ67312Oao557O3HZfAJRfev8uOlgogA46HlFfq6ydSG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="387345848"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="387345848"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 08:12:51 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="746649807"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="746649807"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 08:12:51 -0700
Date:   Mon, 26 Sep 2022 08:13:10 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v2 4/6] fpga: dfl: add generic support for MSIX
 interrupts
In-Reply-To: <Yy3O5OeDjJ99g/M2@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2209260804500.363733@rhweight-WRK1>
References: <20220923121745.129167-1-matthew.gerlach@linux.intel.com> <20220923121745.129167-5-matthew.gerlach@linux.intel.com> <Yy3O5OeDjJ99g/M2@smile.fi.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Fri, 23 Sep 2022, Andy Shevchenko wrote:

> On Fri, Sep 23, 2022 at 05:17:43AM -0700, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Define and use a DFHv1 parameter to add generic support for MSIX
>> interrupts for DFL devices.
>
> ...
>
>> +	if (fid != FEATURE_ID_AFU && fid != PORT_FEATURE_ID_ERROR &&
>> +	    fid != PORT_FEATURE_ID_UINT && fid != FME_FEATURE_ID_GLOBAL_ERR) {
>
>> +
>
> Unneeded blank line.

I will remove the blank line.

>
>> +		v = FIELD_GET(DFH_VERSION, readq(base));
>> +		switch (v) {
>
> This v...
>
>> +		case 0:
>> +			break;
>> +
>> +		case 1:
>> +			v =  readq(base + DFHv1_CSR_SIZE_GRP);
>
> Extra space.
>
> ...and this v are semantically different. It's quite hard to deduce their
> semantics.

I was trying to be consistent with the existing code where the read was 
stored in a temporary variable, v, and the FIELD_GET would be used for the 
specific field.  Will it be sufficiently clear if the v used above is 
changed to dfl_ver, and this use of v followed by FIELD_GET remains as is?

>
>> +			if (FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS, v)) {
>> +				off = dfl_find_param(base + DFHv1_PARAM_HDR, ofst,
>> +						     DFHv1_PARAM_ID_MSIX);
>
> I guess I have suggested to use temporary variable(s) here.
>
> 			void __iomem *dfhv1 = base + DFHv1...;
> 			void __iomem *nth;
>
>> +				if (off >= 0) {
>
> 					nth = dfhv1 + off;
>
>> +					ibase = readl(base + DFHv1_PARAM_HDR +
>> +						      off + DFHv1_PARAM_MSIX_STARTV);
>> +					inr = readl(base + DFHv1_PARAM_HDR +
>> +						    off + DFHv1_PARAM_MSIX_NUMV);
>
> 					ibase = readl(nth + DFHv1_PARAM_MSIX_STARTV);
> 					inr = readl(nth + DFHv1_PARAM_MSIX_NUMV);
>
>> +					dev_dbg(binfo->dev, "start %d num %d fid 0x%x\n",
>> +						ibase, inr, fid);
>> +				}
>> +			}
>> +			break;
>> +
>> +		default:
>> +			dev_warn(binfo->dev, "unexpected DFH version %lld\n", v);
>> +			break;
>> +		}
>> +	}
>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>
>
