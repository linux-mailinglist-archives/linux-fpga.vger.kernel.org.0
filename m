Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2C85B4FC0
	for <lists+linux-fpga@lfdr.de>; Sun, 11 Sep 2022 17:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiIKPkU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Sep 2022 11:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIKPkT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 11 Sep 2022 11:40:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8D312753;
        Sun, 11 Sep 2022 08:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662910819; x=1694446819;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uma3p/ED+ciS4EU3RIneR8AdmYM1uIjtfF/IZxiZ/RY=;
  b=Y4ef5OVbUKllQsXxTVKWsvogJymRjPTgQ+cEeM4Uf0CW1Ja8JptjuOvQ
   EFVA/nALsdiVaA7Wh5RR35OAJjpRcdx1F8ho7tFZW6ogUL86l1UIUaYk4
   QgimXrJ+OBZYR9GqrJ+fMWLoXP3CPQPiyy/J2r99rQbvfSV3PIQZ/Onkl
   QnxhwCIzV0yP9YWPoM0ue7AGKLMFqXgVMiXzdsZZnudZNqi//lNFmNFLY
   v394whOTS8YcfmBPLZvVrlm5Tl8NRUnwK0mUJGnWRKvB3Tc7Q1v7kvuMT
   UPJUTCtaMdseWdkVwy34sEXtNuzKTZTAKQ1uX0cxTslXzTijfb/QVoBKU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="284751532"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="284751532"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 08:40:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="646162617"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 08:40:18 -0700
Date:   Sun, 11 Sep 2022 08:40:32 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        linux-serial@vger.kernel.org, jirislaby@kernel.org,
        geert+renesas@glider.be, andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de,
        Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
Subject: Re: [PATCH v1 2/5] fpga: dfl: Move the DFH definitions
In-Reply-To: <YxgnOYWCSP7ormvK@kroah.com>
Message-ID: <alpine.DEB.2.22.394.2209110838470.142336@rhweight-WRK1>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com> <20220906190426.3139760-3-matthew.gerlach@linux.intel.com> <YxgnOYWCSP7ormvK@kroah.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Wed, 7 Sep 2022, Greg KH wrote:

> On Tue, Sep 06, 2022 at 12:04:23PM -0700, matthew.gerlach@linux.intel.com wrote:
>> --- a/drivers/fpga/dfl.h
>> +++ b/drivers/fpga/dfl.h
>> @@ -2,7 +2,7 @@
>>  /*
>>   * Driver Header File for FPGA Device Feature List (DFL) Support
>>   *
>> - * Copyright (C) 2017-2018 Intel Corporation, Inc.
>> + * Copyright (C) 2017-2022 Intel Corporation, Inc.
>
> I'm all for updated proper copyright dates, but in a patch that
> _removes_ text from a file does not seem like the proper place for that,
> right?  Please discuss with your corporate lawyers as to how to do this
> properly and when to do it.
>
> thanks,
>
> greg k-h
>

Hi Greg,
I discussed how and when to do this properly with my corporate lawyers and 
confirmed this submission is consistent with their guidelines.

You do raise an interesting point, though.  If you think this approach is 
improper, we should probably discuss it, including whether this 
restriction is already a condition for contributions or whether it should 
be.  It wouldn't be the first difference of opinion on the finer points of 
copyright law.

Best Regards,

Matthew Gerlach
