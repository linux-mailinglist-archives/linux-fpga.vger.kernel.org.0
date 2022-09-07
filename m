Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2F45B0EC9
	for <lists+linux-fpga@lfdr.de>; Wed,  7 Sep 2022 23:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiIGVBe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 7 Sep 2022 17:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiIGVBc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 7 Sep 2022 17:01:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BBBAB4DA;
        Wed,  7 Sep 2022 14:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662584489; x=1694120489;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LGhO1rEFSQzLvlqinx1nMOCVFV/CvD0NBb3hwoXn3b4=;
  b=cgkPLwy5xeVUu2aUFSSkp9x8C4zQcfLsT/GfOKOlN8wDQFAZb6lzZW5Y
   LfLwcstWxFLJxNa4ta3CNY6lSJjN5yJSTuWle9Nr4OSoYxFp2CXup+29I
   qAWoYtMFdb2wdYsahQ0AHN54Njsk43IJfT1WhPZTwh9mfy2oBzDlEd4gM
   TUdbet1vsiHLBw6W03Olq8CATDzLXxk32U2fNoVmAq1AFrVQfCoO2Mah9
   CDaLHB2GMSTCVMGjqYTanyXnfU17mjkKutoSYN3MIvqW+ioDPvGD28zB8
   ms73xnytN6g2HFtpjyouLoyX8XcTZsQeJS7iCAKps3aG2OHgWwlVKw+nV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="294579021"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="294579021"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 14:01:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="565674397"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 14:01:28 -0700
Date:   Wed, 7 Sep 2022 14:01:39 -0700 (PDT)
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
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de,
        Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
Subject: Re: [PATCH v1 2/5] fpga: dfl: Move the DFH definitions
In-Reply-To: <YxeoddLVHki/WDUu@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2209071359050.3336870@rhweight-WRK1>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com> <20220906190426.3139760-3-matthew.gerlach@linux.intel.com> <YxeoddLVHki/WDUu@smile.fi.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Tue, 6 Sep 2022, Andy Shevchenko wrote:

> On Tue, Sep 06, 2022 at 12:04:23PM -0700, matthew.gerlach@linux.intel.com wrote:
>> From: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
>>
>> Moving the DFH register offset and register definitions from
>> drivers/fpga/dfl.h to include/linux/dfl.h.  These definitions
>
> Single space?

Sorry for the old habit. I will make it one space.

>
>> need to be accessed by dfl drivers that are outside of
>> drivers/fpga.
>
> ...
>
>> +#define DFH			0x0
>> +#define GUID_L			0x8
>> +#define GUID_H			0x10
>> +#define NEXT_AFU		0x18
>
> While at it, you may make them same width, like "0x08".

The same width does look better.  Thanks for the suggestion.

Matthew Gerlach
>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>
>
