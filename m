Return-Path: <linux-fpga+bounces-1009-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C58A5A1C75E
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 11:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F661883140
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 10:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDC278F4A;
	Sun, 26 Jan 2025 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="OI2VEDgF"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-66.smtpout.orange.fr [80.12.242.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38D4C147;
	Sun, 26 Jan 2025 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737886847; cv=none; b=CH9Et1NlvFDj3CVRrZbyVacE7OeBK8ilGA24uk+h5dpmrI/O5hxOsgPLx3yPpwbWFEBxAh2e6NTcs7MR0+cT0e+9OdCDAPHqt4IcKhPMmpmllN82MKEo8gwWlYhXIBNVdzA55PZEYIJku8p6oXGl9MFrxu4wqjNi6JHkudhDD64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737886847; c=relaxed/simple;
	bh=x9ra0ZsoVm+UnFAT4hGNUty1Hy6Y8S7tZ96KaMMy/2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgBNzLzeMHUqiqBDp7+cNNk1uqWxP6e6PVXPP4KMrUUpjOJZfniD9M4SCf0uc2p8Hvul/g4aufiS/+AMBtlXn2ZhPM3UQClUFbp10sADS4TsOj81MmETxM/G9eP1nSKYXF2i1NvtmDmHS0DlpQJfp81Vvhz89PDgDlYY0P2WLY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=OI2VEDgF; arc=none smtp.client-ip=80.12.242.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id bzjltWA8an48NbzjotziWM; Sun, 26 Jan 2025 11:19:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1737886773;
	bh=xgrBqdilYy1wn5hkmEiVWMq5/KHq9etTESEQjOYFO/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=OI2VEDgFmovzZZ6bb7UPy/veQoT+FHb2BNlnQVj0OGQ6ccvFdyT1XHxkA67yvTsaF
	 J3va+jAaqjRK4eTo+3kaWlf7Ge6cDZsGAZFRwQ4Biw36+sV6xp0GOtOxghbd1cugE/
	 lld74y/b4WqDvmUCGI7ViQ9Ejdx8G3xF28Z6+/Kc3LfaAf2F5n/M3VCPVnYPKdCQCj
	 ieyAsQ/d8dcxNyTNOen8imDTmnieCQBsbIwTtlvxhGV+ijKYQCRByzJGv+WaizFc8R
	 vuNSeAtqo28XpYROlCmzff5FKGUSJMidGYwORNaB1Jxk++FMkl0Vws1Ab+QlNLMtdg
	 fRxr4AXnxx8PA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 26 Jan 2025 11:19:33 +0100
X-ME-IP: 90.11.132.44
Message-ID: <f35c40fc-7afa-4fef-bab2-0b30302b9b21@wanadoo.fr>
Date: Sun, 26 Jan 2025 11:19:29 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/4] drivers/fpga/amd: Add communication channel
To: Yidong Zhang <yidong.zhang@amd.com>, linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org, mdf@kernel.org, hao.wu@intel.com,
 yilun.xu@intel.com
Cc: lizhi.hou@amd.com, Nishad Saraf <nishads@amd.com>
References: <20241210183734.30803-1-yidong.zhang@amd.com>
 <20241210183734.30803-3-yidong.zhang@amd.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241210183734.30803-3-yidong.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 10/12/2024 à 19:37, Yidong Zhang a écrit :
> The communication channel (comm_chan) service is between versal-pci and the
> user PF driver. When the user PF driver requests PL data download, the
> comm_chan service will handle the request by versal_pci_load_xclbin.

...

> +enum comm_chan_req_ops {
> +	COMM_CHAN_REQ_OPS_UNKNOWN		= 0,
> +	COMM_CHAN_REQ_OPS_HOT_RESET		= 5,
> +	COMM_CHAN_REQ_OPS_GET_PROTOCOL_VERSION	= 19,
> +	COMM_CHAN_REQ_OPS_LOAD_XCLBIN_UUID	= 20,
> +	COMM_CHAN_REQ_OPS_MAX,

Unneeded comma after a terminator.

> +};

...

> +static void comm_chan_check_request(struct work_struct *w)
> +{
> +	struct comm_chan_device *ccdev = to_ccdev_work(w);
> +	u32 status = 0, request[COMM_CHAN_DATA_LEN] = {0};

These 2 initialisations are not needed.

> +	struct comm_chan_hw_msg *hw_msg;
> +	u8 type, eom;
> +	int i;
> +
> +	status = comm_chan_read(ccdev, COMM_CHAN_REG_IS_OFF);
> +	if (!STATUS_IS_READY(status))
> +		return;
> +	if (STATUS_IS_ERROR(status)) {
> +		vdev_err(ccdev->vdev, "An error has occurred with comms");
> +		return;
> +	}
> +
> +	/* ACK status */
> +	comm_chan_write(ccdev, COMM_CHAN_REG_IS_OFF, status);
> +
> +	for (i = 0; i < COMM_CHAN_DATA_LEN; i++)
> +		request[i] = comm_chan_read(ccdev, COMM_CHAN_REG_RDDATA_OFF);
> +

...

CJ

