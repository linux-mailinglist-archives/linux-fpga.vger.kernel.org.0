Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2E25B0F44
	for <lists+linux-fpga@lfdr.de>; Wed,  7 Sep 2022 23:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiIGVhX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 7 Sep 2022 17:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiIGVhW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 7 Sep 2022 17:37:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F0A1F61D;
        Wed,  7 Sep 2022 14:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662586641; x=1694122641;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=B4/ksnDW8Xem29FiMzcN7TgkM2msIVMY3Ax00LuxAqE=;
  b=Ox3n59/YSBehX+KG6Dk+Ok6xbVuLn/uMMOleJYXsReqbuGau147U/P1P
   1cvSLYGd7l1mTZMe0shbRIn/pyUXVSheYxu5FvVGqZdGwqhq2BXDD5HAF
   TjCzjTKXKWyMm6ButWb0KKJfgXD4pnqt6H6CJrncpyD4sCfoMdlfbagmj
   i+NqUjCY4LkQJ5Ows+iV8PMJrwl4kMM0g8HsHInDL5FzJkkVIPBBbNrPw
   A+UzzRXVPb4WuhUHi2Z5t/diabR99D4SS5mzdUJexcwrqcL24VV4Aloe3
   CoSZWTuicZ55+9waVx9grOxZJSSSuxwC+248gAGkp8hKF+TjD9R2RkpgA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="323191480"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="323191480"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 14:37:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="591886845"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 14:37:20 -0700
Date:   Wed, 7 Sep 2022 14:37:32 -0700 (PDT)
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
Subject: Re: [PATCH v1 4/5] fpga: dfl: add generic support for MSIX
 interrupts
In-Reply-To: <YxeqTdny7Nu7LzZo@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2209071433320.3336870@rhweight-WRK1>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com> <20220906190426.3139760-5-matthew.gerlach@linux.intel.com> <YxeqTdny7Nu7LzZo@smile.fi.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Tue, 6 Sep 2022, Andy Shevchenko wrote:

> On Tue, Sep 06, 2022 at 12:04:25PM -0700, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Define and use a DFHv1 parameter to add generic support for MSIX
>> interrupts for DFL devices.
>
> ...
>
>> +	if (fid != FEATURE_ID_AFU && fid != PORT_FEATURE_ID_ERROR &&
>> +	    fid != PORT_FEATURE_ID_UINT && fid != FME_FEATURE_ID_GLOBAL_ERR) {
>> +		v = readq(base);
>> +		v = FIELD_GET(DFH_VERSION, v);
>> +
>> +		if (v == 1) {
>> +			v =  readq(base + DFHv1_CSR_SIZE_GRP);
>
> I am already lost what v keeps...
>
> Perhaps
>
> 		v = readq(base);
> 		switch (FIELD_GET(DFH_VERSION, v)) {
> 		case 1:
> 			...
> 			break;
> 		}

How about?
 		if (FIELD_GET(DFH_VERSION, readq(base)) == 1) {
 			...
 		}
>
>> +			if (FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS, v)) {
>
> 				void __iomem *v1hdr = base + DFHv1_PARAM_HDR;
>
>> +				off = dfl_find_param(base + DFHv1_PARAM_HDR, ofst,
>> +						     DFHv1_PARAM_ID_MSIX);
>
> 				off = dfl_find_param(v1hdr, ofst, DFHv1_PARAM_ID_MSIX);
>
>> +				if (off >= 0) {
>> +					ibase = readl(base + DFHv1_PARAM_HDR +
>> +						      off + DFHv1_PARAM_MSIX_STARTV);
>> +					inr = readl(base + DFHv1_PARAM_HDR +
>> +						    off + DFHv1_PARAM_MSIX_NUMV);
>
> 					ibase = readl(v1hdr + off + DFHv1_PARAM_MSIX_STARTV);
> 					inr = readl(v1hdr + off + DFHv1_PARAM_MSIX_NUMV);
>
>> +					dev_dbg(binfo->dev, "%s start %d num %d fid 0x%x\n",
>> +						__func__, ibase, inr, fid);
>
> No __func__ for dev_dbg(). Dynamic debug has this feature at runtime!
>
>> +				}
>> +			}
>> +		}
>> +	}
>
> ...
>
>> +/*
>
> If it's a kernel doc, make it to be parsable as a such.

Yes, the intention is kernel doc. Thanks for the feedback. I
will fix this and add the newline as suggested below.

Matthew Gerlach

>
>> + * dfl_find_param() - find the offset of the given parameter
>> + * @base: base pointer to start of dfl parameters in DFH
>> + * @max: maximum offset to search
>> + * @param: id of dfl parameter
>> + *
>> + * Return: positive offset on success, negative error code otherwise.
>> + */
>> +int dfl_find_param(void __iomem *base, resource_size_t max, int param);
>
> + blank line.
>
>>  #endif /* __LINUX_DFL_H */
>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>
>
