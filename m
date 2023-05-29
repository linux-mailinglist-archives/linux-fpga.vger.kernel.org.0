Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5344714AC6
	for <lists+linux-fpga@lfdr.de>; Mon, 29 May 2023 15:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjE2NvB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 29 May 2023 09:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjE2Nu7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 29 May 2023 09:50:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CD2A7
        for <linux-fpga@vger.kernel.org>; Mon, 29 May 2023 06:50:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C4FC61CD9
        for <linux-fpga@vger.kernel.org>; Mon, 29 May 2023 13:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55652C433EF;
        Mon, 29 May 2023 13:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685368256;
        bh=oeigdkwxUzQXSBgogup8h95mQPWfXAhw29zkGI6MghU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1+yHFAl+xJ8kI3VulfY9Tx8/x9lPUL4xTl5W2pJw/vAuNcmGzu0SOKPEGc4Q2njle
         6LrbUF6gn4OgeVALXQ2PUOti52cv5mfR7U1r+GC5iYJXZI8iqJNK+OHE1qh7I26YAh
         a7zavS3BImHKOTHyF5OLS3++ujEjKpyUkL1OzWEM=
Date:   Mon, 29 May 2023 14:50:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA MAINTAINERS changes for 6.3-final
Message-ID: <2023052937-bluish-remold-48d4@gregkh>
References: <ZFYkMMpovbmoItUS@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFYkMMpovbmoItUS@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, May 06, 2023 at 05:56:00PM +0800, Xu Yilun wrote:
> The following changes since commit dc70eb868b9cd2ca01313e5a394e6ea001d513e9:
> 
>   fpga: bridge: properly initialize bridge device before populating children (2023-04-07 00:10:04 +0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.3-final-2

This doesn't apply at all anymore, can you resend these as patches?

thanks,

greg k-h
