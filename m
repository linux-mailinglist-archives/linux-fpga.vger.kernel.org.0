Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A7D664E9C
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Jan 2023 23:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjAJWQt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 10 Jan 2023 17:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjAJWQs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 10 Jan 2023 17:16:48 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB754D4A9;
        Tue, 10 Jan 2023 14:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673389007; x=1704925007;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SRaBXAGBYCqYgqYsrdvN0StqVlMBENfsuHhSzhILO40=;
  b=Uay20aZowSESnu0Uh17f55zkfpF2qP7Ukgi8b5BxwKjhGDlC1Te2ZDl6
   q1KaVoah5GBGJY1VLToUGetz3vATkRMapTOeK1PcpTPYUyV3pMFzcH3qE
   WdB8R202Exxu+Tx3lhcNDMmgomw7HCPysRYr3sMVCKAL+njo2winGgzJO
   KH6ekfwsBXcCIk6Xn7xnAwNJ8DZdwXSnUrPRqEnKkJOwJIQWh7zr8vBOq
   107jvX1R8bEr87XaDIx8wMRUZK/Kf88rjL2ETTMw3JNF6d6BQmH/7LKHr
   ge25poa92auaB8b1Y1tOn+GSsQ0NRquYQv445jJOOVaSc5Xx/qvZR7MuX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="350496639"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="350496639"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 14:16:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="831143562"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="831143562"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 14:16:32 -0800
Date:   Tue, 10 Jan 2023 14:17:10 -0800 (PST)
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
Subject: Re: [PATCH v10 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
In-Reply-To: <Y70+rAq1QoS4ohdG@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2301101415370.815911@rhweight-WRK1>
References: <20230110003029.806022-1-matthew.gerlach@linux.intel.com> <20230110003029.806022-5-matthew.gerlach@linux.intel.com> <Y70+rAq1QoS4ohdG@smile.fi.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Tue, 10 Jan 2023, Andy Shevchenko wrote:

> On Mon, Jan 09, 2023 at 04:30:29PM -0800, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add a Device Feature List (DFL) bus driver for the Altera
>> 16550 implementation of UART.
>
> ...
>
>> +static int dfh_get_u64_param_val(struct dfl_device *dfl_dev, int param_id, u64 *pval)
>> +{
>> +	size_t psize;
>> +	u64 *p;
>> +
>> +	p = dfh_find_param(dfl_dev, param_id, &psize);
>> +	if (IS_ERR(p))
>> +		return PTR_ERR(p);
>
>> +	if (psize != sizeof(u64))
>> +		return -EINVAL;
>
> If this code stays in the newer versions, make it more robust against changes,
> i.e. by using sizeof(*pval).

Yes, sizeof(*pval) would be more robust if this ode stays in the newer 
versions.

>
>> +	*pval = *p;
>> +
>> +	return 0;
>> +}
>
> ...
>
>> +config SERIAL_8250_DFL
>> +	tristate "DFL bus driver for Altera 16550 UART"
>
> 5
>
>> +	depends on SERIAL_8250 && FPGA_DFL
>> +	help
>> +	  This option enables support for a Device Feature List (DFL) bus
>> +	  driver for the Altera 16650 UART. One or more Altera 16650 UARTs
>
> 6
>
> Which one is correct?

Great catch! The typo has been there since v1.  I will update to 16550.

Thanks,
Matthew Gerlach

>
>> +	  can be instantiated in a FPGA and then be discovered during
>> +	  enumeration of the DFL bus.
>> +
>> +	  To compile this driver as a module, chose M here: the
>> +	  module will be called 8250_dfl.
>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>
>
