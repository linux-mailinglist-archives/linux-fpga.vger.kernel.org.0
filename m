Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FE865A6EE
	for <lists+linux-fpga@lfdr.de>; Sat, 31 Dec 2022 21:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbiLaUqN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 31 Dec 2022 15:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiLaUqM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 31 Dec 2022 15:46:12 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2C9E17;
        Sat, 31 Dec 2022 12:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672519570; x=1704055570;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=u54kgTpFKIhoKkny3N85NEinVLOBvPtOhm1ruzzmbI8=;
  b=RgcvfVsdOez3eQS3yhuWGfp8H1XDb9ClPRs4wn9RDYws8Oxm34W+0e1Y
   Muw3n2oGm8uNmkbmPdE71yipHIDQlQYQ4HrQLSTiXCruAVsqYeseQrIx4
   3NNXMKkkmlMH7dxxUCD4PV0eA7lxTCJVwfHYa/vhZZ4Lai55nzFoj1Hig
   kGBE6ZpDblJqkoK1a62Vlv0qBisdflErTikuXwZ3rAVJPTrQiXjvjCgLg
   Ulyr10v1pJgqQcgg4Mli1XH8znhn5RaF549nlG9oKxmuT/4+hRzwjbfPi
   lgb3fPq1cvdDxmJMrzQQbNHgkxxhzRD75dHkLhyqJyxBInqvXhnBorEvj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="407595726"
X-IronPort-AV: E=Sophos;i="5.96,290,1665471600"; 
   d="scan'208";a="407595726"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2022 12:46:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="982932839"
X-IronPort-AV: E=Sophos;i="5.96,290,1665471600"; 
   d="scan'208";a="982932839"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2022 12:46:08 -0800
Date:   Sat, 31 Dec 2022 12:46:28 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Xu Yilun <yilun.xu@intel.com>
cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        hao.wu@intel.com, russell.h.weight@intel.com,
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
In-Reply-To: <Y6kR632DYwilj505@yilunxu-OptiPlex-7050>
Message-ID: <alpine.DEB.2.22.394.2212311237320.2138420@rhweight-WRK1>
References: <20221220163652.499831-1-matthew.gerlach@linux.intel.com> <20221220163652.499831-4-matthew.gerlach@linux.intel.com> <Y6HqyjFkiUDeNmH1@smile.fi.intel.com> <alpine.DEB.2.22.394.2212211105490.570436@rhweight-WRK1>
 <Y6kR632DYwilj505@yilunxu-OptiPlex-7050>
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



On Mon, 26 Dec 2022, Xu Yilun wrote:

> On 2022-12-21 at 11:14:59 -0800, matthew.gerlach@linux.intel.com wrote:
>>
>>
>> On Tue, 20 Dec 2022, Andy Shevchenko wrote:
>>
>>> On Tue, Dec 20, 2022 at 08:36:51AM -0800, matthew.gerlach@linux.intel.com wrote:
>>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>
>>>> Version 1 of the Device Feature Header (DFH) definition adds
>>>> functionality to the DFL bus.
>>>>
>>>> A DFHv1 header may have one or more parameter blocks that
>>>> further describes the HW to SW.  Add support to the DFL bus
>>>> to parse the MSI-X parameter.
>>>>
>>>> The location of a feature's register set is explicitly
>>>> described in DFHv1 and can be relative to the base of the DFHv1
>>>> or an absolute address.  Parse the location and pass the information
>>>> to DFL driver.
>>>
>>> ...
>>>
>>>> +/**
>>>> + * dfh_find_param() - find data for the given parameter id
>>>> + * @dfl_dev: dfl device
>>>> + * @param: id of dfl parameter
>>>> + *
>>>> + * Return: pointer to parameter header on success, NULL otherwise.
>>>
>>> header is a bit confusing here, does it mean we give and ID and we got
>>> something more than just a data as summary above suggests?
>>
>> Yes, the summary is not correct.  It should say "find the parameter block
>> for the given parameter id".
>>
>>>
>>> In such case summary and this text should clarify what exactly we get
>>> and layout of the data. Since this is a pointer, who is responsible of
>>> checking out-of-boundary accesses? For instance, if the parameters are
>>> variadic by length the length should be returned as well. Otherwise it
>>> should be specified as a constant somewhere, right?
>>
>> The parameter header has the next/size field; so the caller of
>> dfh_find_param should perform boundary checking as part of interpreting the
>> parameter data.  I think a function to perform this checking and data
>> interpretation would help here.
>
> It is better the DFL core provides the size of the parameter block, just
> in this API. It provides the pointer and should be ensured the memory
> for the pointer be correctly understood.

Ok, how about the following API for dfh_find_param?

/**
  * dfh_find_param() - find parameter block for the given parameter id
  * @dfl_dev: dfl device
  * @param_id: id of dfl parameter
  * @pver: destination to store parameter version
  * @pcount: destination to store size of parameter data in u64 bit words
  *
  * Return: pointer to start of parameter data, PTR_ERR otherwise.
  */
void *dfh_find_param(struct dfl_device *dfl_dev, int param_id, unsigned 
*pver, unsigned *pcount)


>
>>
>>>
>>>> + */
>>>> +u64 *dfh_find_param(struct dfl_device *dfl_dev, int param_id)
>>>> +{
>>>> +	return find_param(dfl_dev->params, dfl_dev->param_size, param_id);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(dfh_find_param);
>>>
>>> ...
>>>
>>>> +	finfo = kzalloc(sizeof(*finfo) + dfh_psize, GFP_KERNEL);
>>>
>>> It sounds like a candidate for struct_size() from overflow.h.
>>> I.o.w. check that header and come up with the best what can
>>> suit your case.
>>
>> 	finfo = kzalloc(struct_size(finfo, params, dfh_psize/sizeof(u64)),
>> GFP_KERNEL);
>>
>> Does seem better.
>
> How about we change the dfh_get_psize() to like dfh_get_pcount(), so we
> don't have to multiply & divide back and forth.

We need the size in bytes for calls to kmemdup, devm_kmemdup, and 
memcpy_fromio, but we only need to divide once here.


>
> Or we just use size_add()?

I think using struct_size is better because the params member 
of struct dfl_feature_info is a trailing flexible array.

Thanks for the feedback,
Matthew


>
> Thanks,
> Yilun
>
>>
>> Thanks for the suggestion,
>> Matthew Gerlach
>>
>>
>>>
>>>>  	if (!finfo)
>>>>  		return -ENOMEM;
>>>
>>> --
>>> With Best Regards,
>>> Andy Shevchenko
>>>
>>>
>>>
>
