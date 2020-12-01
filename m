Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53DE2CAA17
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Dec 2020 18:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404160AbgLARqJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Dec 2020 12:46:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404118AbgLARqJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 1 Dec 2020 12:46:09 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCFD420870;
        Tue,  1 Dec 2020 17:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606844728;
        bh=TFtctF/fo2wdRq/+/fdueizT3G1nHZfmWdIrJ55o9fM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ou5kfMPOBSpLgv7VECrYWyeLJFGRos0k10qjhsra8yQlhPowmPcnkpQIBLRuqNU19
         af3ulmn25T1zfJ0mpNONyrBtIGVCz+/pL2dFJAdcthWTJvNuD2Sfd0lEUr05wCDE+d
         h3Gwwjl/S49ahx/9NTzEkiwWoC8EP4RHYwgiE8oA=
Date:   Tue, 1 Dec 2020 18:46:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, trix@redhat.com, hao.wu@intel.com,
        yilun.xu@intel.com, russell.h.weight@intel.com
Subject: Re: [PATCH 0/1] FPGA Manager Fix for 5.10
Message-ID: <X8aBgPqRvKMd2v+d@kroah.com>
References: <20201122001549.107023-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201122001549.107023-1-mdf@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Nov 21, 2020 at 04:15:48PM -0800, Moritz Fischer wrote:
> Hi Greg,
> 
> This time as patchset, as requested last time.
> 
> Please take this fix addressing a missing dependency FPGA_DFL.

Sorry for the long delay, trying to catch up now.  Now queued up.

greg k-h
