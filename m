Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A43E4C0D56
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Feb 2022 08:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiBWHcr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Feb 2022 02:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiBWHcq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 23 Feb 2022 02:32:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2934DF5B
        for <linux-fpga@vger.kernel.org>; Tue, 22 Feb 2022 23:32:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39D0EB81E7B
        for <linux-fpga@vger.kernel.org>; Wed, 23 Feb 2022 07:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF8DC340E7;
        Wed, 23 Feb 2022 07:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645601536;
        bh=Be/OnX+meH29KnAo27FXRKj68/0Vi+9p1gzxPqbhvuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L7BNAB4X1MQzHKFfr1HPNxEHxTaFNKzjDJZ/9U27IzxO27iKLcN6foZKSbeCtMRqw
         bVQWpnubGqZrWPTbgSyS3IU5sMzs7QN/HGCtP5q9tJPROoCsWuK+vepu/qWcz+vuvf
         4KHNtD9Q49Gk8CZD1cQzgnd8yEhauWpDZEp5XbTI=
Date:   Wed, 23 Feb 2022 08:32:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-fpga@vger.kernel.org
Subject: Re: [GIT PULL] firmware: stratix10: fix for v5.17
Message-ID: <YhXi/Yx6Vc/fpCrx@kroah.com>
References: <20220222162801.385838-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222162801.385838-1-dinguyen@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Feb 22, 2022 at 10:28:01AM -0600, Dinh Nguyen wrote:
> The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:
> 
>   Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/stratix10_svc_fix_v5.17
> 
> for you to fetch changes up to 41a069ab421a9540f75314d3e1bfe5fec6bfdf9f:
> 
>   firmware: stratix10-svc: add missing callback parameter on RSU (2022-02-17 06:05:42 -0600)
> 
> ----------------------------------------------------------------
> Stratix10 Service Driver fix for v5.17
> - Add a missing callback parameter
> 
> ----------------------------------------------------------------
> Ang Tien Sung (1):
>       firmware: stratix10-svc: add missing callback parameter on RSU
> 
>  drivers/firmware/stratix10-svc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You forgot to tag the stable tree with this fix.

Please resend this just as a single patch, no need for a pull request
for something like that.  If it was sent as a patch, I could have fixed
it up on my own.

Also, consider adding the "Link:" tag to the original patch submission.

Please fix up and resend.

thanks,

greg k-h
