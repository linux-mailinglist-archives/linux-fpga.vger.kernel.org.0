Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9CE5AFB8D
	for <lists+linux-fpga@lfdr.de>; Wed,  7 Sep 2022 07:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiIGFIS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 7 Sep 2022 01:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGFIR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 7 Sep 2022 01:08:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C604F9C8EE;
        Tue,  6 Sep 2022 22:08:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63E97B81B2E;
        Wed,  7 Sep 2022 05:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DDAC433D6;
        Wed,  7 Sep 2022 05:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662527294;
        bh=aEJWSWI4A4OAZpx07MCeh2OoOctBn8awZPww1oNt340=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0KVbZ4GoEhUuiW3XtluY9o8K2adjsD3YjkIZh6nfIh9M5vgNLUZAupOlQ2EeTncA
         xFj5euYRHfBMsGovoMBeVh6MqRu0VWU2czscyoN9CwGRJZQiSaOjTG7sLxVnfLNacS
         NgO1nrv80CS642o+JUS8DjBzMeYuIoxKvQ8sjKCA=
Date:   Wed, 7 Sep 2022 07:08:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
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
Message-ID: <YxgnOYWCSP7ormvK@kroah.com>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
 <20220906190426.3139760-3-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906190426.3139760-3-matthew.gerlach@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Sep 06, 2022 at 12:04:23PM -0700, matthew.gerlach@linux.intel.com wrote:
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -2,7 +2,7 @@
>  /*
>   * Driver Header File for FPGA Device Feature List (DFL) Support
>   *
> - * Copyright (C) 2017-2018 Intel Corporation, Inc.
> + * Copyright (C) 2017-2022 Intel Corporation, Inc.

I'm all for updated proper copyright dates, but in a patch that
_removes_ text from a file does not seem like the proper place for that,
right?  Please discuss with your corporate lawyers as to how to do this
properly and when to do it.

thanks,

greg k-h
