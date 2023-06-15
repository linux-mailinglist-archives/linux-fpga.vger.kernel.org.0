Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3869773162A
	for <lists+linux-fpga@lfdr.de>; Thu, 15 Jun 2023 13:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245659AbjFOLI3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 15 Jun 2023 07:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245694AbjFOLI1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 15 Jun 2023 07:08:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE752729
        for <linux-fpga@vger.kernel.org>; Thu, 15 Jun 2023 04:08:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8010D6145F
        for <linux-fpga@vger.kernel.org>; Thu, 15 Jun 2023 11:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95385C433C0;
        Thu, 15 Jun 2023 11:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686827305;
        bh=+ytExtzQnwlhFqQFUzO9T7CrhQ9JCvFmHVmIDEx9Ti8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vYWCIIaYfgw8yYDWtWGg1VfVS8n2paq3fydorexV112WkGbwYT3U0fn8Yhj1CERZU
         VbzXqbvHlvme13ZIhzKJFQGb26rVFV6C9jiO0jlKgB/NZd0K/ChFL9mYtBZFFyyacb
         470MA0r1xJcwGwLXHDUeV2hzdoXOzHp0Xk1CqlVg=
Date:   Thu, 15 Jun 2023 13:06:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.5-rc1
Message-ID: <2023061538-level-glorious-1048@gregkh>
References: <ZIdKjGlqzcHGveTV@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIdKjGlqzcHGveTV@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 13, 2023 at 12:40:44AM +0800, Xu Yilun wrote:
> The following changes since commit 44c026a73be8038f03dbdeef028b642880cf1511:
> 
>   Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.5-rc1

Pulled and pushed out, thanks.

greg k-h
