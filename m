Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C2B5BFEF1
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Sep 2022 15:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiIUN2B (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 21 Sep 2022 09:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiIUN16 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 21 Sep 2022 09:27:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FF382D03
        for <linux-fpga@vger.kernel.org>; Wed, 21 Sep 2022 06:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6D7962B55
        for <linux-fpga@vger.kernel.org>; Wed, 21 Sep 2022 13:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D72C433D6;
        Wed, 21 Sep 2022 13:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663766877;
        bh=8s1oprZYiwgUURKu/8/yntuCTl+TK3yISMC4bPTP9T0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GuHIRX92gTViRSLCUZY/wfqR5RtxiG2iGZa/N26jWYcjHluuL2nC08LqRzLjr2VCC
         JIa5pUSlLpTa77tYnfaYhza7tUVkWoaEIuj8+Kw9u18Y4Iu+pV8If756QlfPXz+8n8
         dfNxqg6KVPRD5+pD2l3z82ddtNBLWa2TPVgF6APY=
Date:   Wed, 21 Sep 2022 15:27:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.0-final
Message-ID: <YysRWoagrbfGyPqK@kroah.com>
References: <YylWcADWoTtofAmm@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YylWcADWoTtofAmm@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Sep 20, 2022 at 01:58:08PM +0800, Xu Yilun wrote:
> The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:
> 
>   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.0-final

Pulled and pushed out, thanks.

greg k-h
