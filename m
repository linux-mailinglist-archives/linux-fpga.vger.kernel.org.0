Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C3065B563
	for <lists+linux-fpga@lfdr.de>; Mon,  2 Jan 2023 17:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjABQy3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 2 Jan 2023 11:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjABQy2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 2 Jan 2023 11:54:28 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE14B306;
        Mon,  2 Jan 2023 08:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672678467; x=1704214467;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ppGkbVIp7/QGeKi51q+/ugNHd4lE+7jSrx7vbLG6VvQ=;
  b=afRWpXUyrLxg3VHYr6pHCHSHAiS6Xn1sYSJ/4Pi08ItZTi2eucF5Kstx
   CHR5qL3zvSfZkb67RsnkCGfxDdhv+YrdODiFZiufmmXqrG+i7bgySLZPy
   BCLjAHt0HBobfTrJAsZarJMrrkeCmT+IU1+1Pq1KaEuPSEfKsPN0MfpsT
   PvpdwEfilIm+gH8outCs2OxH6bnJT2RLJX7yIkmSGJQUHK+PTqN97n3BJ
   JMV7X78yzfjuYJTlm995enH/i91B6fB0EgW8TiNLO1f7rI4w1BkKvwegT
   CSXPDx2HJ392Zi8qNMK5AUL1FSY4oInOffCFp3+kc+a7pw6PSsBnCsEm0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="407771523"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="407771523"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 08:54:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="604571189"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="604571189"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 08:54:27 -0800
Date:   Mon, 2 Jan 2023 08:54:48 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Tom Rix <trix@redhat.com>, hao.wu@intel.com, yilun.xu@intel.com,
        russell.h.weight@intel.com, basheer.ahmed.muddebihal@intel.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com
Subject: Re: [PATCH v8 3/4] fpga: dfl: add basic support for DFHv1
In-Reply-To: <Y637aBTrbRloUtvD@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2301020852500.2516029@rhweight-WRK1>
References: <20221228181624.1793433-1-matthew.gerlach@linux.intel.com> <20221228181624.1793433-4-matthew.gerlach@linux.intel.com> <628c125a-5a84-e1bd-7724-2637315cc35e@redhat.com> <Y637aBTrbRloUtvD@smile.fi.intel.com>
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

> On Thu, Dec 29, 2022 at 08:18:03AM -0800, Tom Rix wrote:
>> On 12/28/22 10:16 AM, matthew.gerlach@linux.intel.com wrote:
>
> ...
>
>>>   struct dfl_feature_info {
>>>   	u16 fid;
>>>   	u8 revision;
>>> +	u8 dfh_version;
>>>   	struct resource mmio_res;
>>>   	void __iomem *ioaddr;
>>>   	struct list_head node;
>>>   	unsigned int irq_base;
>>>   	unsigned int nr_irqs;
>>> +	unsigned int param_size;
>>> +	u64 params[];
>> u64 *params
>
> This will break the overflow.h macros, no?
> Besides that it will break the code for sure as it's not an equivalent.
>
>>>   };

I don't understand how this will break the overflow.h macros. The 
definition of struct dfl_feature_info and all of its uses are in a single 
file, dfl.c.

Matthew Gerlach


>
>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>
>
