Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DFD5B24B1
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Sep 2022 19:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiIHReQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Sep 2022 13:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiIHReO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 8 Sep 2022 13:34:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA89BC58C3;
        Thu,  8 Sep 2022 10:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662658453; x=1694194453;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yPoPiu4s5AIvWYRtd6XRgDWLB41yZsUhqTPTHKz4Q3c=;
  b=eS3FwQVzLLKg3O67WOwhilfi72KLy1lY/LqABwz1kdblZii5iG4FBIXv
   /wIyAu4Wh2UuF918bctkB/Tcvx2zS+VbQ5bGYqiDi5SoILhYwmy2/lRau
   aw918TQ2vo0aJqZREtayrb8g7JPcMi1HLPAowTTP0CtL/dV+fBOmes7vG
   BVdI4OJyemvRKAm2X3zwL3kbfn4fEmFTihf/ZIXtuJ1nMOEJzqENN9XxQ
   +CpqIe0vvgoTWsJPBrkNL1R5dGlreewGljci0CQF977ParNRQLAW5g26k
   wvTSHcTB9zjxksVoLnuYWAjCsorWVCkTL4KC2lMoNB9xjEttV7muoNuJq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="298611243"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="298611243"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 10:34:13 -0700
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="676796260"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 10:34:12 -0700
Date:   Thu, 8 Sep 2022 10:34:07 -0700 (PDT)
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
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v1 4/5] fpga: dfl: add generic support for MSIX
 interrupts
In-Reply-To: <YxnMLI17XvjN74DW@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2209081031450.61321@rhweight-WRK1>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com> <20220906190426.3139760-5-matthew.gerlach@linux.intel.com> <YxeqTdny7Nu7LzZo@smile.fi.intel.com> <alpine.DEB.2.22.394.2209071433320.3336870@rhweight-WRK1>
 <YxnMLI17XvjN74DW@smile.fi.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Thu, 8 Sep 2022, Andy Shevchenko wrote:

> On Wed, Sep 07, 2022 at 02:37:32PM -0700, matthew.gerlach@linux.intel.com wrote:
>> On Tue, 6 Sep 2022, Andy Shevchenko wrote:
>>> On Tue, Sep 06, 2022 at 12:04:25PM -0700, matthew.gerlach@linux.intel.com wrote:
>
> ...
>
>>>> +	if (fid != FEATURE_ID_AFU && fid != PORT_FEATURE_ID_ERROR &&
>>>> +	    fid != PORT_FEATURE_ID_UINT && fid != FME_FEATURE_ID_GLOBAL_ERR) {
>>>> +		v = readq(base);
>>>> +		v = FIELD_GET(DFH_VERSION, v);
>>>> +
>>>> +		if (v == 1) {
>>>> +			v =  readq(base + DFHv1_CSR_SIZE_GRP);
>>>
>>> I am already lost what v keeps...
>>>
>>> Perhaps
>>>
>>> 		v = readq(base);
>>> 		switch (FIELD_GET(DFH_VERSION, v)) {
>>> 		case 1:
>>> 			...
>>> 			break;
>>> 		}
>>
>> How about?
>> 		if (FIELD_GET(DFH_VERSION, readq(base)) == 1) {
>> 			...
>> 		}
>
> This one tends to be expanded in the future, so I would keep it switch case.
>

I'm okay with using the switch statement, but how about the following?

 		switch (FIELD_GET(DFH_VERSION, readq(base))) {
                 case 1:
 			...
 			break;
 		}
> -- 
> With Best Regards,
> Andy Shevchenko
>
>
>
