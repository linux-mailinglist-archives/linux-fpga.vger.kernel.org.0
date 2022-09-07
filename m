Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306915B0D07
	for <lists+linux-fpga@lfdr.de>; Wed,  7 Sep 2022 21:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiIGTPV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 7 Sep 2022 15:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiIGTPT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 7 Sep 2022 15:15:19 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F49ADCD2;
        Wed,  7 Sep 2022 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662578115; x=1694114115;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VXLGR9Wd6RtBhueFT65gXUYPfx/9KwI70lZVxZ42xt8=;
  b=IfFLDaJQMt6gA6kr9kV8FdldFg9PGEV9kpAbLg7WMmk7iWSRSzHfQ9y7
   A0ZSYNi3DcO4qMFSEEB9iJ+u928h558YD4sUy4PURfsMq2lBHX4OrxdSm
   QnkakVlnVFoIYF4nxNpEsesThtWEiOeFi2wkYQkgRw7nyr6vnVBMUBbo/
   ggI23LB+Jtk9CsnYPSsEiiFct/OxtiBd4WU/DIwz94E279PugN4CiuCzv
   Tin+23hF1Rv6vlWBo4js2b6o2ZZhW3/KCgKsI0VHt3Cajbme7JjrZsmLt
   5dg7Qda2zsBlHfWBOTYR08hB5/jXnG/u6bkiTacybcOXG2tmbaiZZTAZd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="296974067"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="296974067"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 12:15:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="682942460"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 12:15:13 -0700
Date:   Wed, 7 Sep 2022 12:15:12 -0700 (PDT)
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
Subject: Re: [PATCH v1 1/5] Documentation: fpga: dfl: Add documentation for
 DFHv1
In-Reply-To: <YxeovjbDq1IP7PZk@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2209071214410.3336870@rhweight-WRK1>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com> <20220906190426.3139760-2-matthew.gerlach@linux.intel.com> <YxeovjbDq1IP7PZk@smile.fi.intel.com>
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

> On Tue, Sep 06, 2022 at 12:04:22PM -0700, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add documentation describing the extentions provided by Version
>> 1 of the Device Feature Header (DFHv1).
>
> ...
>
>> +With DFHv0, not all features types contained a GUID.  DFHv1 makes the GUILD standard
>> +across all types.
>
> GUI_L_D?
>

Thanks for the review and pointing out the typo.

Matthew Gerlach
> -- 
> With Best Regards,
> Andy Shevchenko
>
>
>
