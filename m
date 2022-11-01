Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF5261552D
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Nov 2022 23:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiKAWi2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Nov 2022 18:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiKAWiK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 1 Nov 2022 18:38:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FE81EC5A;
        Tue,  1 Nov 2022 15:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667342250; x=1698878250;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TSOGjnjupfOrdH3obGXGgrrinoXppjy4+FuK31YZweg=;
  b=G8pMiDlSYIRGCEJRmldyxYiv3IK3CuffNiKpBT0LCbD68fQ0FBU6teTQ
   fJ/SBV3+Z6n1QLI2qvnx4pa4ZZ3iP51939QGJ11tGFwc1R/xhxI2qGuCp
   moSaQDVhUoIRPgivxi0Jv3n2Ot2fbLDV6cPqCUZbRBY+JWEgc1KgcsU1v
   6SOKGcd4sJ9Z7EaT7/xwULIVHG1Hzbm+OFCtus0Yb3Y0H1mYzqhljbW5p
   p6nikBvfd9nprCpibvVtSScsj1HFOuKUg11tcUW8tnerzJmlIuhvbNZID
   zitarmXJgP7vBNhNqGef9EXCcrmTvS4mQEkn4JO3JOftOvL+IVfqLFgmn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="310360135"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="310360135"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 15:37:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="723320146"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="723320146"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 15:37:27 -0700
Date:   Tue, 1 Nov 2022 15:37:19 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Xu Yilun <yilun.xu@intel.com>
cc:     hao.wu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net, jirislaby@kernel.org,
        geert+renesas@glider.be, andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com
Subject: Re: [PATCH v4 3/4] fpga: dfl: add basic support DFHv1
In-Reply-To: <alpine.DEB.2.22.394.2210290739540.2504975@rhweight-WRK1>
Message-ID: <alpine.DEB.2.22.394.2211011520290.2767909@rhweight-WRK1>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com> <20221020212610.697729-4-matthew.gerlach@linux.intel.com> <Y10l3NkIn0gsdVZq@yilunxu-OptiPlex-7050> <alpine.DEB.2.22.394.2210290739540.2504975@rhweight-WRK1>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Sat, 29 Oct 2022, matthew.gerlach@linux.intel.com wrote:

>
>>
>>>  	if (!finfo)
>>>  		return -ENOMEM;
>>> 
>>> +	if (dfh_psize > 0) {
>>> +		memcpy_fromio(finfo->params,
>>> +			      binfo->ioaddr + ofst + DFHv1_PARAM_HDR, 
>>> dfh_psize);
>>> +		finfo->param_size = dfh_psize;
>>> +	}
>>> +
>>>  	finfo->fid = fid;
>>>  	finfo->revision = revision;
>>> -	finfo->mmio_res.start = binfo->start + ofst;
>>> -	finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
>>> +	finfo->dfh_version = dfh_ver;
>>>  	finfo->mmio_res.flags = IORESOURCE_MEM;
>>> -	finfo->irq_base = irq_base;
>>> -	finfo->nr_irqs = nr_irqs;
>>> +	if (dfh_ver == 1) {
>>> +		v = readq(binfo->ioaddr + ofst + DFHv1_CSR_ADDR);
>>> +		if (v & DFHv1_CSR_ADDR_REL)
>>> +			finfo->mmio_res.start = v & ~DFHv1_CSR_ADDR_REL;
>>> +		else
>>> +			finfo->mmio_res.start = binfo->start + ofst +
>>> +					       FIELD_GET(DFHv1_CSR_ADDR_MASK, 
>>> v);
>>> +
>>> +		v = readq(binfo->ioaddr + ofst + DFHv1_CSR_SIZE_GRP);
>>> +		finfo->mmio_res.end = finfo->mmio_res.start +
>>> +				      FIELD_GET(DFHv1_CSR_SIZE_GRP_SIZE, v) - 
>>> 1;
>> 
>> So for dflv1, no feature header resource for dfl_device, is it a problem
>> for dfl_uio? Does userspace driver need the raw feature header?
> These are two very good questions.  The dfl_uio driver question is 
> particularly relevent because user space is looking at the GUIDs.
>

In the case of dfl_uio driver, user space will definitely want to look at 
the feature header for the GUID and the parameters.  Since DFHv1 can have 
the DFH header and the feature registers in non-contiguous memory 
locations, a resource for the dfl_device will be required.  In earlier
revisions of this patch set, a second resource was added called csr_res 
pointing to the feature's register while mmio_res pointed at the header.
Do we just need better names or do we need an array of named resources?

>> 
>>> +	} else {
>>> +		finfo->mmio_res.start = binfo->start + ofst;
>>> +		finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
>>> +	}
>>> +
>>> +	ret = parse_feature_irqs(binfo, ofst, finfo);
>>> +	if (ret) {
>>> +		kfree(finfo);
>>> +		return ret;
>>> +	}
>>>
