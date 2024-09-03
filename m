Return-Path: <linux-fpga+bounces-706-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D81969A58
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Sep 2024 12:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B58DB24173
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Sep 2024 10:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20CE1C62BA;
	Tue,  3 Sep 2024 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j+RRV36c"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1301C62B3
	for <linux-fpga@vger.kernel.org>; Tue,  3 Sep 2024 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359942; cv=none; b=b0256lHkxFzkh/Pe+5tOVU21o93XoDKPS6gWkSnKogYNOr2yrs4cQ0nsQ1kuTZyPK1RdkuL7FhdhPJvgQ/9v4ehz3dEeXaRqMFX6bSt0Ue0UlOiH+UuEgFfwnoGviw74iwl5HaBP3XSWBd970ak1Sl/zFR6qk/ZE9bP4Hdge1DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359942; c=relaxed/simple;
	bh=hJdIfOgX4YmVtCz6zuf0R44AgesR2cYr0CUAF0ewfdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6CuoEdDw8eJcZJY9RxQvhTQGanA07D39f9kchTpDs8am15G9JMRs7m/uWJ7XTLHC0ApWEUx7tdXgYgxJcwAq+SZElfVf8eXg2HWQlxsZPLcYiqsjRr6Gn5yU51QV52F/6ssLDm6WSR2hSeQZXpDEefnGRDGCoM3qtONvT+HmQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j+RRV36c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D24C4CEC4;
	Tue,  3 Sep 2024 10:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725359942;
	bh=hJdIfOgX4YmVtCz6zuf0R44AgesR2cYr0CUAF0ewfdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j+RRV36cl7fcHtr9IhiwW4Nocb01o/R083vTlwadpkx4vviSj03CYB7O2ZPxMt3mo
	 0KNc9geNd9w0he/IvA6ZysvxIurwqZivFgMo79+8PF/yI4Vy5CHN54kbCB1FGi66JQ
	 MNcqmSdqooWL6upLqTbikUL7jwl59utWefP2xh2w=
Date: Tue, 3 Sep 2024 12:09:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
	mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.12-rc1
Message-ID: <2024090356-imprison-stowaway-51f1@gregkh>
References: <ZtM8QWGFKIRLc+NZ@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtM8QWGFKIRLc+NZ@yilunxu-OptiPlex-7050>

On Sat, Aug 31, 2024 at 11:52:33PM +0800, Xu Yilun wrote:
> The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:
> 
>   Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.12-rc1

Pulled and pushed out, thanks.

greg k-h

