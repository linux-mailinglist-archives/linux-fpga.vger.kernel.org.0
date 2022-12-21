Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BBF653874
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Dec 2022 23:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbiLUWQS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 21 Dec 2022 17:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbiLUWQP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 21 Dec 2022 17:16:15 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE9E1DDF9;
        Wed, 21 Dec 2022 14:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671660975; x=1703196975;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=03DkSFxEcwRQKDCzgQAsLNxCg54/977/OYmPD7a5R6I=;
  b=Bnx4aXy07bsCgt8cn4URmBoXCkgbFe70edc2qFIr0mWJn1eCy1aya6la
   9Jx4WJEbLs07yEhhz/vVivNrX7SZ8Pw6M0vMcZjo/uO0wfVVqY9wZ7Vkz
   WoEMGs9YusZT3qxUARuVyhbpq8UlYX5mEIDwlr1fzIaZ6bhnJDIH2CffU
   VHSJxaise/kHzre0SEllo4daR27W9i3gczYT0jSr3ydNSE68KonoRXdX5
   2pUM9ApGXDXiuBYuZs+R5YhPLcGERO2+4SIxIGAtKY2246VT6O7G7bcTd
   ZRFweR7OW4mJZ2BlSvEoX7cFzzx+bP9+z7hdiaASVF6H5+P9vm757VdNE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="303414315"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="303414315"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 14:16:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="980342495"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="980342495"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 14:16:12 -0800
Date:   Wed, 21 Dec 2022 14:16:38 -0800 (PST)
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
Subject: Re: [PATCH v7 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
In-Reply-To: <Y6HsQJQMDnHgTesF@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2212211404270.570436@rhweight-WRK1>
References: <20221220163652.499831-1-matthew.gerlach@linux.intel.com> <20221220163652.499831-5-matthew.gerlach@linux.intel.com> <Y6HsQJQMDnHgTesF@smile.fi.intel.com>
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



On Tue, 20 Dec 2022, Andy Shevchenko wrote:

> On Tue, Dec 20, 2022 at 08:36:52AM -0800, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add a Device Feature List (DFL) bus driver for the Altera
>> 16550 implementation of UART.
>
> In general the code here looks good to me, but one thing to discuss due to
> comment to the previous patch(es).
>
> ...
>
>> +	u64 *p;
>> +
>> +	p = dfh_find_param(dfl_dev, DFHv1_PARAM_ID_CLK_FRQ);
>> +	if (!p)
>> +		return dev_err_probe(dev, -EINVAL, "missing CLK_FRQ param\n");
>> +
>> +	p++;
>> +	uart->port.uartclk = *p;
>
> So, here and the below is using always the second u64 from the returned data.
> Does it mean:
> - we always skip the first u64 from the returned buffer and hence... (see below)

The first u64 of the parameter block, the parameter header, contains a 
version field and a next/size field that a parameter consumer might use.
The version field determines the exact layout of the data, and the 
next/size field could/should be used to prevent out of bounds accesses.

> - we may actually return the second u64 as a plain number (not a pointer) from
>  (an additional?) API? In such case we would not need to take care about this
>  p++; lines here and there.

I think an additional API that can be used to fetch an array of u64's 
while also checking boundary conditions would be helpful.

> - we have fixed length of the data, returned by find_param(), i.e. 2 u64 words?

The length and layout of the parameter data is determined by the parameter 
id and version. So the data portion of a parameter is not fixed length.

Thanks for the feedback,
Matthew Gerlach

>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>
>
