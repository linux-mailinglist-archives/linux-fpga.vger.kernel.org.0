Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0028552C5E
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Jun 2022 09:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347386AbiFUHt6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Jun 2022 03:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347477AbiFUHtz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 21 Jun 2022 03:49:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496A524586
        for <linux-fpga@vger.kernel.org>; Tue, 21 Jun 2022 00:49:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5F8C61482
        for <linux-fpga@vger.kernel.org>; Tue, 21 Jun 2022 07:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E91EC3411D;
        Tue, 21 Jun 2022 07:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655797793;
        bh=/CssD/eNzr+shBBDxq/jjgmo4dvURV1XEfYwL3vbmAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t5aKGZfUTyLJ2uUntJsu+cH0Xl/dtUJvmCl5kPd++yQWEu65vBl4SsNpM5POglHMI
         BV4SjGNg8BAs5/jaKq/4FifQjHefgRERp9VcmrhhZhtZKvLvaLxmv4jwOCbCzBaXGS
         G3JnnlgUy9eHETOpI7bpEy3megXoIyvlrm8SdLCY=
Date:   Tue, 21 Jun 2022 09:49:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for v5.20-rc1
Message-ID: <YrF4Dshke4LeJyGA@kroah.com>
References: <20220621065501.GA1527017@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621065501.GA1527017@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 21, 2022 at 02:55:01PM +0800, Xu Yilun wrote:
> The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:
> 
>   Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga.git tags/fpga-for-5.20-rc1

Pulled and pushed out, thanks.

greg k-h
