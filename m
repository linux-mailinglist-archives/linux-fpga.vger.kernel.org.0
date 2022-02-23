Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D414C0D63
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Feb 2022 08:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiBWHhD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Feb 2022 02:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236926AbiBWHhC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 23 Feb 2022 02:37:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5B8DB8
        for <linux-fpga@vger.kernel.org>; Tue, 22 Feb 2022 23:36:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA6AE614D4
        for <linux-fpga@vger.kernel.org>; Wed, 23 Feb 2022 07:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7683C340E7;
        Wed, 23 Feb 2022 07:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645601790;
        bh=FBhar8yqOoKm8GjecX+4lYDQK4SqQbeNFcEKM9pDahI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zACiRKZD+M5Hm+I36Os9Ir3TRo70pRfF5yfnn8q++SCQPuh3VLsiHplbfzKWY9fag
         ihkraAli9uHlWJ/KqCWPs/+fOFfi2PMX46Cm5KOgR9gFLn3kCA41fW38y3wud4kii3
         QYhblnuZCPgEAvWMI6CcLInpL19+SBZNHd0+NgfU=
Date:   Wed, 23 Feb 2022 08:36:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-fpga@vger.kernel.org
Subject: Re: [GIT PULL] firmware: stratix10: updates for v5.18
Message-ID: <YhXj+yhH0qTUunxW@kroah.com>
References: <20220222164407.386381-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222164407.386381-1-dinguyen@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Feb 22, 2022 at 10:44:07AM -0600, Dinh Nguyen wrote:
> The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:
> 
>   Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/stratix10_svc_updates_for_v5.18
> 
> for you to fetch changes up to 91e50169b52ed59272e675d0c1ea107a36c843da:
> 
>   firmware: stratix10-svc: extend SVC driver to get the firmware version (2022-02-17 06:20:43 -0600)
> 
> ----------------------------------------------------------------
> Stratix10 Service Driver for v5.18
> - Update MAINTAINER's entry to include a git address

This patch should be added to 5.17-final, right?

Again, if you had sent me this as just patches, I could have fixed it
for you :(

Let's stick with patches for now, no need for a git tree for such small
changes.

Please fix up.

thanks,

greg k-h
