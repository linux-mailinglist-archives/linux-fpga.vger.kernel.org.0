Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B0B7CC9AF
	for <lists+linux-fpga@lfdr.de>; Tue, 17 Oct 2023 19:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjJQRRg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 Oct 2023 13:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbjJQRRf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 17 Oct 2023 13:17:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E941F0
        for <linux-fpga@vger.kernel.org>; Tue, 17 Oct 2023 10:17:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4125C433C7;
        Tue, 17 Oct 2023 17:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697563054;
        bh=zZ7JxZLJgDAGzTdo+S9KnJVcP4K3X528Xxd8d/pK4wQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qX7AZ+CgXoqCJxbyn0Ylf7QkfrkdPGHBCC8hGMygyTYrdx6wvd7YE6chbfx/yiRou
         Vc4n+IgoNPlZHLglSHxyunpc8NNHI1mdehDEsgNxu+Ymor5j9u+i6fuIQZfuPwrMfN
         54gEtFY0t9PL3U9uxvu35XtsG5j54utBPUxXpM7s=
Date:   Tue, 17 Oct 2023 19:17:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@linux.intel.com>
Cc:     yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
        mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.6-final
Message-ID: <2023101730-budding-spree-1471@gregkh>
References: <ZS6hhlvjUcqyv8zL@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS6hhlvjUcqyv8zL@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Oct 17, 2023 at 11:00:22PM +0800, Xu Yilun wrote:
> The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:
> 
>   Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.6-final
> 
> for you to fetch changes up to 6a935361500a21ef11a82814ee66fc58e59813f7:
> 
>   fpga: Fix memory leak for fpga_region_test_class_find() (2023-10-12 12:59:29 +0800)
> 
> ----------------------------------------------------------------
> FPGA Manager changes for 6.6-final
> 
> FPGA KUnit test:
> 
> - Marco's change fixes null-ptr-deref when try_module_get()
> - Jinjie's change fixes a memory leak issue
> 
> Intel m10 bmc secure update:
> 
> - Maintainer change from Russ Weight to Peter Colberg
> 
> All patches have been reviewed on the mailing list, and have been in the
> last linux-next releases (as part of our fixes branch)
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> 
> ----------------------------------------------------------------
> Jinjie Ruan (1):
>       fpga: Fix memory leak for fpga_region_test_class_find()
> 
> Marco Pagani (4):
>       fpga: add helpers for the FPGA KUnit test suites.
>       fpga: add a platform driver to the FPGA Manager test suite
>       fpga: add a platform driver to the FPGA Bridge test suite
>       fpga: add a platform driver to the FPGA Region test suite

Why are all of these test suite patches here?  They are not relevant for
6.6-final as they do not resolve anything.

I can see the memory leak being relevant, and also:

> Russ Weight (1):
>       fpga: m10bmc-sec: Change contact for secure update driver

That one, but why the testing code?  What bug/regression are they
fixing?

thanks,

greg k-h
