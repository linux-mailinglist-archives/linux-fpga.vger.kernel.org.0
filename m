Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43227606EEE
	for <lists+linux-fpga@lfdr.de>; Fri, 21 Oct 2022 06:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJUEct (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 21 Oct 2022 00:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJUEcr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 21 Oct 2022 00:32:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100681D8F2F;
        Thu, 20 Oct 2022 21:32:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A33A661DAB;
        Fri, 21 Oct 2022 04:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B334C433B5;
        Fri, 21 Oct 2022 04:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666326766;
        bh=u7K+0gFbuznMXX0zZi/e5MTUPFXzYUhWZbyrap0BG+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RkTs9JCNhX0dmx1uKuUfylhDWtw4/UQdMqBRBIFvda98GR4XQw6doLr/ulm6nfLZQ
         fCzmYmi73Mm4+Kmc3/fc5BjKoiU0MZ30E1kj09/loxmH3MbEPODSbtiN6dWrmH7uyW
         vhDDM6aq93WvIdu5FqdYMMIwM+4zfS+HcUllRxzk=
Date:   Fri, 21 Oct 2022 06:33:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        linux-serial@vger.kernel.org, jirislaby@kernel.org,
        geert+renesas@glider.be, andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com
Subject: Re: [PATCH v4 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
Message-ID: <Y1IhH9RV4p5pU4zj@kroah.com>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com>
 <20221020212610.697729-5-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020212610.697729-5-matthew.gerlach@linux.intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Oct 20, 2022 at 02:26:10PM -0700, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add a Device Feature List (DFL) bus driver for the Altera
> 16550 implementation of UART.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>

As per the rules of how Intel developers are supposed to send out
patches, I can't take this.  Please work with the Intel kernel developer
team to get this properly reviewed first, and the correct reviews,
before sending it out again.

thanks,

greg k-h
