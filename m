Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322245B4FD4
	for <lists+linux-fpga@lfdr.de>; Sun, 11 Sep 2022 17:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiIKP4Y (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Sep 2022 11:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIKP4X (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 11 Sep 2022 11:56:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FD427CC3;
        Sun, 11 Sep 2022 08:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662911782; x=1694447782;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CHo/70Apm0vFrqIDwUA26aY7oyXaYe3fjINmtC1WoR4=;
  b=igFHGHjgC2vRulLMzEFCjVwJLYDnd90QY9Pb1tiDpRafzD2R+vnAMK9u
   rOfgE6nDaJx6sj383hvuKD9a6uGHlQ5Q9eDN0YGyw12X4mAGB2slUobx6
   x55My3lAe1yQE1wj9HWhD29c3mUwguqQs/MyZcNeYxR9I51iiCklwphOU
   PN5t8uFFTwC4q5YRLbgSRbLmm6pR01iuG1vbZ3mjHRAgSP9vyXObB1KHg
   V+bx8d3GZN84O7UjpVqaMTSjgKYZ/KPhWfaF9ssCVpy09B9H3dlBcf+RP
   RZU4QPJl4mgQv19iIJ+WEmAKqJTIiFQwawwovbcjlaQBes+aeVIVjqs7p
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="295317128"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="295317128"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 08:56:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="649002397"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 08:56:21 -0700
Date:   Sun, 11 Sep 2022 08:56:41 -0700 (PDT)
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
Subject: Re: [PATCH v1 5/5] tty: serial: 8250: add DFL bus driver for Altera
 16550.
In-Reply-To: <Yxpbx0Tclqy4O9cR@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2209110850120.142336@rhweight-WRK1>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com> <20220906190426.3139760-6-matthew.gerlach@linux.intel.com> <YxesjfoBagiC3gGE@smile.fi.intel.com> <alpine.DEB.2.22.394.2209081049290.61321@rhweight-WRK1>
 <Yxpbx0Tclqy4O9cR@smile.fi.intel.com>
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



On Fri, 9 Sep 2022, Andy Shevchenko wrote:

> On Thu, Sep 08, 2022 at 11:27:03AM -0700, matthew.gerlach@linux.intel.com wrote:
>> On Tue, 6 Sep 2022, Andy Shevchenko wrote:
>>> On Tue, Sep 06, 2022 at 12:04:26PM -0700, matthew.gerlach@linux.intel.com wrote:
>
> ...
>
>>>> +	dev_dbg(dfluart->dev, "UART_CLK_ID %llu Hz\n", dfluart->uart_clk);
>>>
>>> Isn't this available via normal interfaces to user?
>>
>> I am not sure what "normal interfaces to user" you are referring to.  The
>> code is just trying to read the frequency of the input clock to the uart
>> from a DFH paramter.
>
> I mean dev_dbg() call. The user can get uart_clk via one of the UART/serial
> ABIs (don't remember which one, though).

I don't think UART/serial ABIs to get the input clock frequency would be 
available until after the call to serial8250_register_8250_port() which 
needs the clock frequency as an input.

>
>
> ...
>
>>>> +#define FME_FEATURE_ID_UART 0x24
>>>
>>> Purpose of this definition? For me with or without is still an ID.
>>
>> I don't think I understand the question. Is the name of the macro unclear,
>> or do you think it is not necessary?
>
> I mean how the definition is useful / useless. I.o.w. I think it's not
> necessary.

The macro may not be necessary, but its usage is consistent with other dfl 
bus drivers.

Thanks for the feedback,
Matthew Gerlach

>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>
>
