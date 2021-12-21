Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B019947BC7A
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Dec 2021 10:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhLUJGu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Dec 2021 04:06:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57460 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbhLUJGu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 21 Dec 2021 04:06:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24CB46147C
        for <linux-fpga@vger.kernel.org>; Tue, 21 Dec 2021 09:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A15C36AE2;
        Tue, 21 Dec 2021 09:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640077609;
        bh=ccKMqlRxPJ9qh818EiDDq3Q4pY9hvuj5GOB8W9kevOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i4KeAEbwmxEYw+LDOzVRePrijIdYfI3cLIqhPYCS3MpRYGW3zQtNOmVCRIVtdfry4
         3MKHpagx5QwCA3uECDD52mJNw9MI4haU0uIyEwt8XgOIwBvZg/lprnAqesHlmcowmh
         mo70UrObtkDEmPIRyRBFz7n+kfNpwY1XExjRYKXI=
Date:   Tue, 21 Dec 2021 10:06:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, yilun.xu@intel.com, hao.wu@intel.com
Subject: Re: [GIT PULL] FPGA Manager changes for 5.17-rc1
Message-ID: <YcGZIHeiran+FW1O@kroah.com>
References: <Ybz51pwucMjutPsA@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybz51pwucMjutPsA@epycbox.lan>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Dec 17, 2021 at 12:57:58PM -0800, Moritz Fischer wrote:
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> 
>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga tags/fpga-for-5.17-rc1

Pulled and pushed out, thanks.

greg k-h
