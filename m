Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735DF653460
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Dec 2022 17:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbiLUQwJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 21 Dec 2022 11:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbiLUQwI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 21 Dec 2022 11:52:08 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9716014022;
        Wed, 21 Dec 2022 08:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671641523; x=1703177523;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=S9pWCvR46VodArTH+e1JhaYdw/4YCeVczrVbUr7Q8rs=;
  b=nLA688zAOwGnHTnllXDpUtqM3VkoQBBdYECIRuYv5XYW3MEkzVSZgRqQ
   PUIO/eafuWiMsT7PNvH1YWQaJzqLKN4vlK/L2WmEpBiy02Gh5YzJ6r18O
   Yzorpr+T8kIUpI9C0rbQwkqY+HdePhsH7T8NTcYiRUwIsMy05Xl3llfl/
   e2QUoiMwL4LVuyxRQDA1gBEdrcl6VCePJYc2yhMnZmqKuoTJ7j9H1w4EE
   m1elLgyNbrT6AAEFUBGaHnr4RQWrHOPH/0QRjpeQUOZ3pYLgg57ytJfwx
   MjNPcf+ZA0cipJ6XXAkjIFp+sS3UijYi0drxajj16hbWtQw9se+ahJYVl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="319970492"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="319970492"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 08:52:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="683860005"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="683860005"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 08:52:02 -0800
Date:   Wed, 21 Dec 2022 08:52:22 -0800 (PST)
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
Subject: Re: [PATCH v7 1/4] Documentation: fpga: dfl: Add documentation for
 DFHv1
In-Reply-To: <Y6Hop0WhtOWRWg3t@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2212210850250.570436@rhweight-WRK1>
References: <20221220163652.499831-1-matthew.gerlach@linux.intel.com> <20221220163652.499831-2-matthew.gerlach@linux.intel.com> <Y6Hop0WhtOWRWg3t@smile.fi.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Tue, 20 Dec 2022, Andy Shevchenko wrote:

> On Tue, Dec 20, 2022 at 08:36:49AM -0800, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add documentation describing the extensions provided by Version
>> 1 of the Device Feature Header (DFHv1).
>
> ...
>
>> +Device Feature Header - Version 0
>> +===========================================
>
> Shouldn't this be the same length as the title itself?
> Have you run make htmldocs and kernel doc validator on
> this file after your change? Also you can use rst2pdf
> to see PDF rendering.

Yes, it should be the same as the title itself.  I will change it 
accordingly.  I ran "make htmldocs" and rst2pdf, and resulting html and 
pdf looked fine.

Thanks for the review,
Matthew Gerlach

>
> Same to the other title.
>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>
>
