Return-Path: <linux-fpga+bounces-1266-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C038BAEDEDC
	for <lists+linux-fpga@lfdr.de>; Mon, 30 Jun 2025 15:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BA13BFA5F
	for <lists+linux-fpga@lfdr.de>; Mon, 30 Jun 2025 13:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1080728B7F8;
	Mon, 30 Jun 2025 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MkOujb4V"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA94728B7EF;
	Mon, 30 Jun 2025 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751289351; cv=none; b=Tx7Isie7ceszNj77AkSgvjpm7sKqazYoVSmfnCu0L0mdwwJWXuyKRl6QSPITPrFZUCPTBLu/nVr9ZV2EOeuRwad/QH1SBjALiKmJTxNXvRwhnVkDHQ36ar99uyXi/MXwgUSvGisJaXHdr5oO6xjPlmbvLzyYMMCYYxmhUq6aQDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751289351; c=relaxed/simple;
	bh=1y6vmVuDYenWeLrLPlwct+pyU/EgPCro2JAQe6Hydgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3wnX3QVBF29HNJmEtuEIfcY+XZnolbBTgnAYg8OIAfKVZdkyFxlzPiUzZt1rGUEcTWC/ILWCQ9kUTi5g9p+Lv+F5bfd7vDZ1CjY4hqQ2e+UijgUYL8Xb+rsW75slQlzbPqkXtmRGdWnSqGHOyRUOy+RiYQJZEt3HpLN5sti6O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MkOujb4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE83C4CEF1;
	Mon, 30 Jun 2025 13:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751289351;
	bh=1y6vmVuDYenWeLrLPlwct+pyU/EgPCro2JAQe6Hydgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MkOujb4VFvtoHPHFke1pQ9V0orbmqc6400lTZIRq0ZB2bAAZVwWgiM9mwaLEpaOXq
	 iA6glFdeck0fPEL3sXxqaCn7ej4Nk8ywG7Lbu6jFALemjh3NESa+Ej7usegv573JuD
	 tz6Kx4re8JK3VYHwYZNxuKx61erWb83ufs7WvzOg=
Date: Mon, 30 Jun 2025 15:15:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ryan Chung <seokwoo.chung130@gmail.com>
Cc: hao.wu@intel.com, trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: Replace scnprintf() with sysfs_emit()
Message-ID: <2025063046-grub-lego-59a4@gregkh>
References: <20250630125018.48417-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630125018.48417-1-seokwoo.chung130@gmail.com>

On Mon, Jun 30, 2025 at 09:50:18PM +0900, Ryan Chung wrote:
> Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>

I know I can't take patches without any changelog text, but maybe other
maintainers are more lax?

Also, you only said what you did, but not why you did it.

> ---
>  drivers/fpga/dfl-afu-main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 3bf8e7338dbe..f2dd4667a43d 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -156,7 +156,7 @@ id_show(struct device *dev, struct device_attribute *attr, char *buf)
>  	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
>  	int id = port_get_id(fdata);
>  
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", id);
> +	return sysfs_emit(buf, PAGE_SIZE, "%d\n", id);

Did you build this?  Did you test it?

>  }
>  static DEVICE_ATTR_RO(id);
>  
> @@ -475,7 +475,7 @@ afu_id_show(struct device *dev, struct device_attribute *attr, char *buf)
>  	guidh = readq(base + GUID_H);
>  	mutex_unlock(&fdata->lock);
>  
> -	return scnprintf(buf, PAGE_SIZE, "%016llx%016llx\n", guidh, guidl);
> +	return sysfs_emit(buf, PAGE_SIZE, "%016llx%016llx\n", guidh, guidl);

Same here, was this built?

And what's wrong with the original code?

thanks,

greg k-h

