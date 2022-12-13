Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7645764BE0C
	for <lists+linux-fpga@lfdr.de>; Tue, 13 Dec 2022 21:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbiLMUk6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 13 Dec 2022 15:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236726AbiLMUk4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 13 Dec 2022 15:40:56 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F99915721;
        Tue, 13 Dec 2022 12:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670964054; x=1702500054;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SJZ5dxjy2IoP7M1/SfzQe61iypYUZ8AnkAmDD0aKUFw=;
  b=Zo+rJJQ1wBA5W13cQzWICvZNCaDJ+5wB6EQIJYN6jsSg4tIba/+Kp7Et
   xOHr3u/oZ4mSYF+XmAo0eDU8lAkti9x0Ybn7awnQ9N1d3/yuEgISE5x7k
   ReHSRbecm49O3Orcfk652sbjjvMYEf6zFn83E3U0jGUM4uFd3DPOvPKMl
   R+8A9L8NBEsbxfn/KYl3q8JtiYIZrI5Tt0DDvYSyShawvdbfI5r0cz4KH
   iS+bMI1oCCB7UpNE+PKtz+iddn3JGlRX/E1TdKaGiTaOPIliN+iQmDN8U
   iHa0SdeQYlkg6W2OJEoaxDud9Bs9GsiJ1hagjlrCJXLTr7D7pQNOJJVD1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="305871924"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="305871924"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 12:40:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="894030103"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="894030103"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 12:40:52 -0800
Date:   Tue, 13 Dec 2022 12:41:13 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Bagas Sanjaya <bagasdotme@gmail.com>, hao.wu@intel.com,
        yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com
Subject: Re: [PATCH v6 1/4] Documentation: fpga: dfl: Add documentation for
 DFHv1
In-Reply-To: <Y5jX/eXrFdAO7xml@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2212131239410.3747445@rhweight-WRK1>
References: <20221209214523.3484193-1-matthew.gerlach@linux.intel.com> <20221209214523.3484193-2-matthew.gerlach@linux.intel.com> <Y5P6NjDxy/S7nlF7@debian.me> <alpine.DEB.2.22.394.2212130844330.3732069@rhweight-WRK1> <Y5jX/eXrFdAO7xml@smile.fi.intel.com>
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



On Tue, 13 Dec 2022, Andy Shevchenko wrote:

> On Tue, Dec 13, 2022 at 08:50:25AM -0800, matthew.gerlach@linux.intel.com wrote:
>> On Sat, 10 Dec 2022, Bagas Sanjaya wrote:
>>> On Fri, Dec 09, 2022 at 01:45:20PM -0800, matthew.gerlach@linux.intel.com wrote:
>
> ...
>
>>>>  Open discussion
>>>>  ===============
>>>>  FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration
>>>
>>> What about this wording below (including fitting the prose within 80 columns)?
>>
>> The wording you suggest is an improvement. I will include your suggestions.
>> I mistakenly thought that Restructured Text needed list items to be a single
>> line and checkpatch.pl did not flag the long lines.
>
> I usually test the output with rst2pdf. You can also try kernel doc script to
> produce man and HTML and see how they are rendered.

I have been using 'make htmldocs' and viewing the output.  I will checkout 
rst2pdf as well.

Thanks for the feedback,
Matthew Gerlach

>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>
>
