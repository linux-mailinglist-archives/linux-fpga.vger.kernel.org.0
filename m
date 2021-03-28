Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C4734BC75
	for <lists+linux-fpga@lfdr.de>; Sun, 28 Mar 2021 14:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhC1M7Q (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 28 Mar 2021 08:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231137AbhC1M6t (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 28 Mar 2021 08:58:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46F7961934;
        Sun, 28 Mar 2021 12:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616936328;
        bh=nCdjx5H6qfv5TVfsDdXet0dkOYX8X4ti3HFAVzGxJgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RiDvaPhJzQ9N/ffLH8mBlSh8AaWrU7ic7kUF+DMCzs+voVQF6OSFHxcN/cSpaRtyP
         d0PwLMGxPL++0ye16AAdJ/p6etiDI/4yJSbPTEy1S3Q0MHpDyQY6937vCIksuVrJyy
         kEfCuea5VlmTFCwAFJrOR5P3fC702UUmzlP8YuZ4=
Date:   Sun, 28 Mar 2021 14:58:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com
Subject: Re: [PATCH v12 0/2] UIO support for dfl devices
Message-ID: <YGB9hlEQpjwE5dfo@kroah.com>
References: <1615168776-8553-1-git-send-email-yilun.xu@intel.com>
 <20210316051005.GA461@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316051005.GA461@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Mar 16, 2021 at 01:10:05PM +0800, Xu Yilun wrote:
> Hi Greg:
> 
> I listed below some answers from Moritz and Yilun from previous mails for
> your question.
> 
> Do you have more comments?

Nah, it's fine, now queued up, thanks.

greg k-h
