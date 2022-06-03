Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BAA53C89C
	for <lists+linux-fpga@lfdr.de>; Fri,  3 Jun 2022 12:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243522AbiFCKWu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 3 Jun 2022 06:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiFCKWh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 3 Jun 2022 06:22:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B630C642E;
        Fri,  3 Jun 2022 03:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654251755; x=1685787755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WF+UZTi1QOwSbfXLEfc65TwAKhi+9MpRsucGq2PY9BU=;
  b=SABZb9oqjS/AdvAeHwq2kWSIjdVHTb94LjfgjQXO269/ZwPuM7X8ZtyY
   I66W7bs0ypaCB8mdC43ACnYaiZ20bIMbz0n2n1LuM942b1GsM0Fp60IJn
   IsDJTj1ljQB/0ZSUQjJ6qE4CmWiwcCNXGBBdLrdQ8hDVU/48UYgzBmkLP
   10ULZqwVcing8QwrAVWCd6j9hUrc3U/ODGCSWqa/JytBNDqV7nAt+8AmO
   hB3+6JtOSHt8OTZHM4uN0/8nVIKEBrbJuSZDQ0lOVDKNb909zJsKQ3Wpw
   qGQva8kGtex2kTl1cnQROhQOW3zbQW1m6in3QDFeD7O/ZQosuWS91eQF+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="275022490"
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="275022490"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 03:22:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="530959412"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga003.jf.intel.com with ESMTP; 03 Jun 2022 03:22:33 -0700
Date:   Fri, 3 Jun 2022 18:14:43 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     tien.sung.ang@intel.com
Cc:     dinh.nguyen@intel.com, hao.wu@intel.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, trix@redhat.com
Subject: Re: [PATCH] fpga: altera-cvp: allow interrupt to continue next time
Message-ID: <20220603101443.GB238410@yilunxu-OptiPlex-7050>
References: <20220528120400.GA175058@yilunxu-OptiPlex-7050>
 <20220531022004.2314963-1-tien.sung.ang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531022004.2314963-1-tien.sung.ang@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, May 31, 2022 at 10:20:04AM +0800, tien.sung.ang@intel.com wrote:
> >> CFG_READY signal/bit may time-out due to firmware not responding
> >> within the given time-out. This time varies due to numerous
> >> factors like size of bitstream and others.
> >> This time-out error does not impact the result of the CvP
> >> previous transactions. The CvP driver shall then, respond with
> 
> >Do you mean the reprogramming is successful even if you find the time
> >out in write_complete()? Then return 0 is better?
> Based on the information given by the Intel FPGA firmware team,
> CFG_READY is essential to indicate if the current FPGA 
> configuration session is indeed a success. There are 
> cases we test in the lab whereby, CFG_READY stays invalid and
> the tests performed subsequently to verify the FPGA functionality
> could not detect the failed session. A failed FPGA 
> configuration session means, the new bitstream wasn't 
> successfully configured and tests ran later will just be passing
> on the previous working bitstream version. In short, CFG_READY
> is esential, and an error indicating the time-out is a must.
> Another example, using an incorrect SOF/Design FPGA results
> in CFG_READY being invalid. The user must be informed of a 
> potential error. 
> I will correct the wordings i used earlier that says that
> the timoeut error does not impact the results of the CvP
> previous transactions. It may so if the firmware has some sort
> of error. 

Understood. But with your new comment why you must change the error
code to -EAGAIN rather than timeout?

I think you may change your commit message. The main change is adding
the error handling. The error code change is minor, even not necessary
if you don't have a strong reason.

Thanks,
Yilun

> 
> >And could you specify what the time-out mean on write_init() phase?
> I could not really understand your question. We set huge 
> time-outs of ~10seconds. Every wait for the firmware to respond
> is potentially a hazard. The firmware CvP is has it's limitation
> unfortunately. 


