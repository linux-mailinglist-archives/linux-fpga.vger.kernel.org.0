Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6031C3E14AF
	for <lists+linux-fpga@lfdr.de>; Thu,  5 Aug 2021 14:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbhHEM1N (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 5 Aug 2021 08:27:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232651AbhHEM1M (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 5 Aug 2021 08:27:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A56961108;
        Thu,  5 Aug 2021 12:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628166417;
        bh=BbIyh3t+WbIzpxEb7+V8J2yG8OAhYXwlhs7GIHJRMDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nJqG/s1FQi8QTQTKNJHMqMG8slrjlfaraFFFKtUXrGxBSTCUsZa/beMOGUz10CpGw
         YmnlBZMg2hiitszUNovhKZuAe1oNb5bu3LtoxohKPdAvhKHsobE2tG6CPkOuf1w45I
         0mGU0YmheCq1cIBUbdhY2mRoi/zzWfxYLtcywJBY=
Date:   Thu, 5 Aug 2021 14:26:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com
Subject: Re: [GIT PULL] FPGA Manager changes for 5.15-rc1
Message-ID: <YQvZCN2e+Htzu4wv@kroah.com>
References: <YQqy6mso7Ukf6NYq@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQqy6mso7Ukf6NYq@archbook>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Aug 04, 2021 at 08:31:54AM -0700, Moritz Fischer wrote:
> The following changes since commit 630211a17055bafd21fb83ae8c0002b2e214ebb2:
> 
>   fpga: fpga-mgr: wrap the write_sg() op (2021-07-24 15:10:31 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-for-5.15

Pulled and pushed out, thanks.

greg k-h
