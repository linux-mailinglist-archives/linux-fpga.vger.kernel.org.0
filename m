Return-Path: <linux-fpga+bounces-928-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 305DB9C4102
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Nov 2024 15:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6146A1C2183C
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Nov 2024 14:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B6019D060;
	Mon, 11 Nov 2024 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vxvy4Jr0"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D01F1E481
	for <linux-fpga@vger.kernel.org>; Mon, 11 Nov 2024 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335641; cv=none; b=jCkk8mm5e90R4yuK0QO8DJP4rcT6udDLBTOse+h1GPXOlzVMq2LluI6kHI2XrlzQt5aBPF4G7bCgIisYmqX2Kkt2pc/D+Blupu7VhF+UwdioJfo/hYvgX1ZmzcBzHDG4tjNU2H2YTO8cJ0il6EXnYaZWRXuFvjbyCwXyYW/1HGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335641; c=relaxed/simple;
	bh=X9/823CCfdbYwo7Gi5FsO/7OSmIRmAeZ3y1x3PN0ge4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWyE7WH6FrTCTkuIJQcYrocKaeGAK5WgEPjtX7KNLNpwj03btwE3MyxVS/cm/9YzSJ/d3fhvyR2hS2ar+8F6SOOOrHio1+nWVyXqwwCD7IG70cJrYFvPcZPEBtENsB3E0biuNK9kskt3f+fFKT7zJzvMuAEneUSCbT2pXBQd4uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vxvy4Jr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8BEC4CECF;
	Mon, 11 Nov 2024 14:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731335641;
	bh=X9/823CCfdbYwo7Gi5FsO/7OSmIRmAeZ3y1x3PN0ge4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vxvy4Jr0HNmukpyrBEXi2K3Of8DgVoaDCBxTLiHbUPc7I/B5t5ExN7us0rMQRN3Jf
	 L2HnzyrdS5MBkGX+Z+DWgjgTjAwQPmc0mvON3Amidn6X98NtgSEsxlQGdTQ4vK8GYw
	 v91SIVajbDNtb2tiyZzqJXmEVcdY7cwyIZNDqL2I=
Date: Mon, 11 Nov 2024 15:33:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
	mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.13-rc1
Message-ID: <2024111142-stereo-guy-588f@gregkh>
References: <ZzF8revoFulyrG7F@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzF8revoFulyrG7F@yilunxu-OptiPlex-7050>

On Mon, Nov 11, 2024 at 11:40:29AM +0800, Xu Yilun wrote:
> The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:
> 
>   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.13-rc1

Pulled and pushed out, thanks.

greg k-h

