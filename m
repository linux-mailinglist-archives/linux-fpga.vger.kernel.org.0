Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CD6658FE9
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Dec 2022 18:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiL2RbO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Dec 2022 12:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbiL2Ras (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Dec 2022 12:30:48 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC99396;
        Thu, 29 Dec 2022 09:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672335043; x=1703871043;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jzJmJ8hNoMsewqwbxcPd1etes2MnlJv/Rt5CviLAz5E=;
  b=N17Q1U+j0UPm09zmjsfo2XlGVatUgI0QMpU9RjFvRhyJn+GSovwuTYD2
   TYSm2mWi96kKOpcYTYGBYUaE4jMzyaIOHkvSOJqRLLKroJBAXW2aK2/Z1
   g70eSzy63Z+PnZvGn6vpOwWPwnUWsmaP4wHvSZud0QG556lFZAAXwnDFD
   SETjXtSaF57/THypDrtkC42Sz6CYBssMVatSea4tnRVeAW62q+y0RzqPM
   RKCDy7pyGPqJxtxZsczTiDTOOeMRkypLCEMJTGX9lmbb68ubB2NR3U/fl
   kq7DDtyHYlnfNrA/bs4+CiBvEaYOyVrI9HjE4zP7pes9Du3BQIn2DxJF2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="319798857"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="319798857"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 09:30:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="777740202"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="777740202"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 09:30:43 -0800
Date:   Thu, 29 Dec 2022 09:31:02 -0800 (PST)
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
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com
Subject: Re: [PATCH v8 3/4] fpga: dfl: add basic support for DFHv1
In-Reply-To: <Y61kb9OGikxLvAcr@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2212290911001.1857691@rhweight-WRK1>
References: <20221228181624.1793433-1-matthew.gerlach@linux.intel.com> <20221228181624.1793433-4-matthew.gerlach@linux.intel.com> <Y61kb9OGikxLvAcr@smile.fi.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Thu, 29 Dec 2022, Andy Shevchenko wrote:

> On Wed, Dec 28, 2022 at 10:16:23AM -0800, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Version 1 of the Device Feature Header (DFH) definition adds
>> functionality to the DFL bus.
>>
>> A DFHv1 header may have one or more parameter blocks that
>> further describes the HW to SW.  Add support to the DFL bus
>
> Single space is enough.

Yes, single space is enough. Two spaces after a period is hard habit for 
me break. I will update in v9.

>
>> to parse the MSI-X parameter.
>>
>> The location of a feature's register set is explicitly
>> described in DFHv1 and can be relative to the base of the DFHv1
>> or an absolute address.  Parse the location and pass the information
>> to DFL driver.
>
> I'm wondering what DFL states for.

I will define DFL in the commit message like DFH in the next revision.

>
> ...
>
>> +/**
>> + * dfh_get_u64_param_vals() - get array of u64 param values for given parameter id
>> + * @dfl_dev: dfl device
>> + * @param: id of dfl parameter
>> + * @pval: location of parameter data destination
>> + * @nvals: number of u64 elements of parameter data
>> + *
>> + * Return: pointer to start of parameter block, PTR_ERR otherwise
>> + */
>> +u64 *dfh_get_u64_param_vals(struct dfl_device *dfl_dev, int param_id, u64 *pval, int nvals)
>> +{
>> +	u64 *param = find_param(dfl_dev->params, dfl_dev->param_size, param_id);
>> +	u64 next;
>> +	int i;
>> +
>> +	if (!param)
>> +		return ERR_PTR(-ENOENT);
>> +
>> +	next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, *param);
>> +
>> +	if (nvals >= next)
>> +		return ERR_PTR(-ENOMEM);
>
> ENODATA ?

ENODATA does seem to be more accurate than ENOMEM in this case.

>
>> +	for (i = 0; i < nvals; i++)
>> +		*pval++ = param[i + 1];
>
> memcpy() ?

Using memcpy() will make code cleaner.

>
>> +	return param;
>> +}
>
> ...
>
>> +	finfo = kzalloc(struct_size(finfo, params, dfh_psize/sizeof(u64)), GFP_KERNEL);
>
> ' / ' (mind the spaces)

Yes, I will mind the spaces.

>
> Also, perhaps better to use sizeof(*params) or what is the member of that
> structure. So it will be more robust against possible changes.

params is the name of the structure member that is the trailing array.

>
>>  	if (!finfo)
>>  		return -ENOMEM;
>
> -- 
> With Best Regards,
> Andy Shevchenko

Thanks for the feedback,
Matthew Gerlach

>
>
>
