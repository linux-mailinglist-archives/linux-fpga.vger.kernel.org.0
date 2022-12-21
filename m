Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959696536E2
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Dec 2022 20:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiLUTPA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 21 Dec 2022 14:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiLUTO7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 21 Dec 2022 14:14:59 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769CE24BF6;
        Wed, 21 Dec 2022 11:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671650098; x=1703186098;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kMA1CCqwKf3gzZUMOreeGnmHrmC6lT06XSLiP61YOQs=;
  b=f+yoKhgtATYZlSuUghtoDd6FOI91Ja9M5QQ4BZV5/APxKL7mBVmY1h0+
   /d7DVwVHRPBf4ySX9TYdz5BxDMKY4EVUiZ11iV6ctTHkGcpk6TfY+XpOq
   w+LfHFTu59U27Lt8JE6AxhdVPMOryIZD5X5HUorhaNAZLmjpqQ2cc7ben
   fyI2m2IylnnO9GAi17VDBI6mNixPnW+p7N3gaXx3wpEs6aW/czUlS+LWN
   zwfebe6DXbfntp2nx81MIMC579o7z5j+d6PcPCj4g9fce1Bc6HHlvciQA
   l9ZqQF45XSEcaKo2flb5RwNzC1X4x1Y/ckdPXDXKvUCWRFyqdS+dXRG0n
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="317591521"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="317591521"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 11:14:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="683908511"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="683908511"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 11:14:33 -0800
Date:   Wed, 21 Dec 2022 11:14:59 -0800 (PST)
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
Subject: Re: [PATCH v7 3/4] fpga: dfl: add basic support for DFHv1
In-Reply-To: <Y6HqyjFkiUDeNmH1@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2212211105490.570436@rhweight-WRK1>
References: <20221220163652.499831-1-matthew.gerlach@linux.intel.com> <20221220163652.499831-4-matthew.gerlach@linux.intel.com> <Y6HqyjFkiUDeNmH1@smile.fi.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Tue, 20 Dec 2022, Andy Shevchenko wrote:

> On Tue, Dec 20, 2022 at 08:36:51AM -0800, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Version 1 of the Device Feature Header (DFH) definition adds
>> functionality to the DFL bus.
>>
>> A DFHv1 header may have one or more parameter blocks that
>> further describes the HW to SW.  Add support to the DFL bus
>> to parse the MSI-X parameter.
>>
>> The location of a feature's register set is explicitly
>> described in DFHv1 and can be relative to the base of the DFHv1
>> or an absolute address.  Parse the location and pass the information
>> to DFL driver.
>
> ...
>
>> +/**
>> + * dfh_find_param() - find data for the given parameter id
>> + * @dfl_dev: dfl device
>> + * @param: id of dfl parameter
>> + *
>> + * Return: pointer to parameter header on success, NULL otherwise.
>
> header is a bit confusing here, does it mean we give and ID and we got
> something more than just a data as summary above suggests?

Yes, the summary is not correct.  It should say "find the parameter block 
for the given parameter id".

>
> In such case summary and this text should clarify what exactly we get
> and layout of the data. Since this is a pointer, who is responsible of
> checking out-of-boundary accesses? For instance, if the parameters are
> variadic by length the length should be returned as well. Otherwise it
> should be specified as a constant somewhere, right?

The parameter header has the next/size field; so the caller of 
dfh_find_param should perform boundary checking as part of interpreting 
the parameter data.  I think a function to perform this checking 
and data interpretation would help here.

>
>> + */
>> +u64 *dfh_find_param(struct dfl_device *dfl_dev, int param_id)
>> +{
>> +	return find_param(dfl_dev->params, dfl_dev->param_size, param_id);
>> +}
>> +EXPORT_SYMBOL_GPL(dfh_find_param);
>
> ...
>
>> +	finfo = kzalloc(sizeof(*finfo) + dfh_psize, GFP_KERNEL);
>
> It sounds like a candidate for struct_size() from overflow.h.
> I.o.w. check that header and come up with the best what can
> suit your case.

 	finfo = kzalloc(struct_size(finfo, params, dfh_psize/sizeof(u64)), 
GFP_KERNEL);

Does seem better.

Thanks for the suggestion,
Matthew Gerlach


>
>>  	if (!finfo)
>>  		return -ENOMEM;
>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>
>
