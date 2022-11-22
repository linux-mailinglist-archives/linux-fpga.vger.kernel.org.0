Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F201B63425B
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Nov 2022 18:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbiKVRR7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Nov 2022 12:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiKVRR6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Nov 2022 12:17:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B706E575
        for <linux-fpga@vger.kernel.org>; Tue, 22 Nov 2022 09:17:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27E5E617F3
        for <linux-fpga@vger.kernel.org>; Tue, 22 Nov 2022 17:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8D8C433D6;
        Tue, 22 Nov 2022 17:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669137476;
        bh=b5eYKhQnVTPOEefeMIpyZWYMSAwbGl6IYf5EGBPcgfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=REws5qXQHDIri5UTm1tPtG7N1xUb3OTXUaMnCjR5uIdLGMqaP00GdwAaRbXTLq6rG
         Os/uU3NNWcZUaA5vzlYVYbtxgO8CvfoOnOtbIe+IE5ralYvNQEHQH58Sipt96OM+1Z
         QubW5kPkv+2aI5eXaBGXTsmBTfwOOe5oVqwxASkE=
Date:   Tue, 22 Nov 2022 18:17:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.1-final
Message-ID: <Y30EQF8drKgyVGcr@kroah.com>
References: <Y3T9jtqxT3Nja1Rk@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3T9jtqxT3Nja1Rk@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Nov 16, 2022 at 11:11:10PM +0800, Xu Yilun wrote:
> The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:
> 
>   Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.1-final

Pulled and pushed out, thanks.

greg k-h
