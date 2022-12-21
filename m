Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592726538CB
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Dec 2022 23:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbiLUWhO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 21 Dec 2022 17:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbiLUWgj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 21 Dec 2022 17:36:39 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8C0E36;
        Wed, 21 Dec 2022 14:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671662198; x=1703198198;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CSuTSRNf7BVJ26/vVNpg852swFu8pb0DaMkyR4IOx0Y=;
  b=bd7CwxMNEUCU38Bf0Ez+ThbRhw/sW+Nuy4hpsVvdmdw039NEE/fLrXYh
   LrMjBDkAh/YHPytNFnK3rgwU0quePCa0qZZOfXRy69aqDHYgGPmBw2qib
   vfuw/zun33jio6aFMEEqAYQI7oX1zf0McZRDO8F2mCSOHEXh8osuYGdRA
   0CiP1eHzeFN4pbFvazF0TgwHWXkl1P1rHCNch1u6jeRXjRb/kwkuWnriA
   4/sow9Du8xUFgDk9bGPdse6Hjfwb9ba6vRn/55VsEWZLCgUjXNIenGjPv
   7RU4Q2bBQvV1dX8xDpR6D5btvnfI9MRN7T0SYv34k7/PlV4gY3ufU6D2C
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="303419288"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="303419288"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 14:36:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="758693326"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="758693326"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 14:36:37 -0800
Date:   Wed, 21 Dec 2022 14:37:02 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Marco Pagani <marpagan@redhat.com>
cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        bagasdotme@gmail.com
Subject: Re: [PATCH v7 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
In-Reply-To: <70c7daf8-379e-1479-aba5-4476c4a93b9f@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2212211434520.570436@rhweight-WRK1>
References: <20221220163652.499831-1-matthew.gerlach@linux.intel.com> <20221220163652.499831-5-matthew.gerlach@linux.intel.com> <Y6HsQJQMDnHgTesF@smile.fi.intel.com> <d34b021c-eec4-905e-f352-734db2d8338a@redhat.com>
 <70c7daf8-379e-1479-aba5-4476c4a93b9f@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Wed, 21 Dec 2022, Marco Pagani wrote:

>
> On 2022-12-21 18:26, Marco Pagani wrote:
>>
>>
>> On 2022-12-20 18:09, Andy Shevchenko wrote:
>>> On Tue, Dec 20, 2022 at 08:36:52AM -0800, matthew.gerlach@linux.intel.com wrote:
>>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>
>>>> Add a Device Feature List (DFL) bus driver for the Altera
>>>> 16550 implementation of UART.
>>>
>>> In general the code here looks good to me, but one thing to discuss due to
>>> comment to the previous patch(es).
>>>
>>> ...
>>>
>>>> +	u64 *p;
>>>> +
>>>> +	p = dfh_find_param(dfl_dev, DFHv1_PARAM_ID_CLK_FRQ);
>>>> +	if (!p)
>>>> +		return dev_err_probe(dev, -EINVAL, "missing CLK_FRQ param\n");
>>>> +
>>>> +	p++;
>>>> +	uart->port.uartclk = *p;
>>>
>>> So, here and the below is using always the second u64 from the returned data.
>>> Does it mean:
>>> - we always skip the first u64 from the returned buffer and hence... (see below)
>>> - we may actually return the second u64 as a plain number (not a pointer) from
>>>   (an additional?) API? In such case we would not need to take care about this
>>>   p++; lines here and there.
>>> - we have fixed length of the data, returned by find_param(), i.e. 2 u64 words?
>>>
>>
>> I also had the impression that this method of getting and incrementing a pointer
>> to the beginning of the parameter block is a bit more error-prone than necessary.
>> Since parameter blocks are now standardized, wouldn't be easier and safer to wrap
>> the access logic into a helper function like:
>>
>> u16 dfh_get_param_data(struct dfl_device *dfl_dev, u16 param_id, u64 *data)
>>
>> that directly provides a copy of the parameter's data into a pointer provided by
>> the caller and returns the parameter version or an error if not found?
>
> Please ignore the last part of my reply. The diagram in the documentation made
> me think that parameter data are always 64-bit wide. Since the parameter data
> "payload" size depends on the version and ID, an eventual helper function could
> then return a pointer to the data payload and the version number to the caller.

Certainly helper functions should be created to make accessing the actual 
parameter easier and safer.

Thanks for the feedback,
Matthew Gerlach

>
> Thanks,
> Marco
>
>
>
