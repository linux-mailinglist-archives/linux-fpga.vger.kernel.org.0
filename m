Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716C465B67B
	for <lists+linux-fpga@lfdr.de>; Mon,  2 Jan 2023 19:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbjABSJc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 2 Jan 2023 13:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbjABSJa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 2 Jan 2023 13:09:30 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3EBA464;
        Mon,  2 Jan 2023 10:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672682969; x=1704218969;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=u0cKWq5UhALwaWgyRXoKx+AMTrECSa5KGHsicEUKVqU=;
  b=ZzyH9Hyu9pwVzzKnwpCVHaEe1zppWmCNHqz9bz+RsMLVqlh9a/TD+DlR
   2Dzij87CpvlxaB13RhVrZksC9OynJdnh2J2cCINGj9XRRt9bKPMymzx1H
   qvPsr2AlJvfpDaOOIBYsPkIhethifL6jy+oq4LqHSCmNkR9EFvbIw/Nmu
   ksxZfgx1KcLmA1xqbKISCi5m9b1Fy8GFcvn6xax+2bwUpBL6KRb/9w42E
   47xFxgP6Nbndkv+HB95HRU1ZjEyvYdHFmE1Fnz67H/+A6G58bhlf9YVR1
   1wpocqfr1cmfuBKrTj45oBgIyfnocbJuQLuVqVcHKTkjc00wGvS362jNQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="323515068"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="323515068"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 10:09:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="828629888"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="828629888"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 10:09:25 -0800
Date:   Mon, 2 Jan 2023 10:09:45 -0800 (PST)
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
In-Reply-To: <Y7MUOQ/X/ls5/+RP@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2301020955550.2536944@rhweight-WRK1>
References: <20221228181624.1793433-1-matthew.gerlach@linux.intel.com> <20221228181624.1793433-4-matthew.gerlach@linux.intel.com> <628c125a-5a84-e1bd-7724-2637315cc35e@redhat.com> <Y637aBTrbRloUtvD@smile.fi.intel.com> <alpine.DEB.2.22.394.2301020852500.2516029@rhweight-WRK1>
 <Y7MT6e8c2VLCjZuw@smile.fi.intel.com> <Y7MUOQ/X/ls5/+RP@smile.fi.intel.com>
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



On Mon, 2 Jan 2023, Andy Shevchenko wrote:

> On Mon, Jan 02, 2023 at 07:27:06PM +0200, Andy Shevchenko wrote:
>> On Mon, Jan 02, 2023 at 08:54:48AM -0800, matthew.gerlach@linux.intel.com wrote:
>>> On Thu, 29 Dec 2022, Andy Shevchenko wrote:
>>>> On Thu, Dec 29, 2022 at 08:18:03AM -0800, Tom Rix wrote:
>>>>> On 12/28/22 10:16 AM, matthew.gerlach@linux.intel.com wrote:
>
> ...
>
>>>>>> +	u64 params[];
>>>>> u64 *params
>>
>>>> This will break the overflow.h macros, no?
>>>> Besides that it will break the code for sure as it's not an equivalent.
>>
>>> I don't understand how this will break the overflow.h macros. The definition
>>> of struct dfl_feature_info and all of its uses are in a single file, dfl.c.
>>
>> Hint: __must_be_array()
>>
>> As I said, the proposed change is not acceptable since it's not an equivalent.
>
> Ah, you meant that there is no use of macros from overflow in the dfl.c?
> IIRC we discussed that some of the code may make use of them, or am I
> mistaken?

There currently is one usage of struct_size() from overflow.h in dfl.c, 
and my patch adds another usage of struct_size(). struct dfl_feature_info 
ends with a trailing array of u64.

I think the confusion is with struct dfl_feature and/or struct struct 
dfl_device. Those structs don't end with a trailing array, and those 
structs are not used with macros from overview.h.

Thanks for the feedback,
Matthew Gerlach

>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>
>
