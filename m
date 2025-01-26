Return-Path: <linux-fpga+bounces-1008-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B525A1C754
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 11:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4CD1672BA
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 10:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE29017BEC6;
	Sun, 26 Jan 2025 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="oWf1L3hO"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-81.smtpout.orange.fr [80.12.242.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4B01714CF;
	Sun, 26 Jan 2025 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737886608; cv=none; b=mumUo0ouek4SoOlpWTBqu9j08Y4uXi7wwZpg0rfBwX6SBi54MP16f3Hi0nG2KzznBfAegWcRlD0ziJrfb/PxqHr39UigapIzBPN87ydDEAGikKbegiDrrPdc8Zr/gP9WC6QXnb8N9pSUaNA9CUia/da9Pk42G1KGBJm77TafbQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737886608; c=relaxed/simple;
	bh=i4alPHciWAhoqgT/+WGjUEKruTP79ibTYyEr9sCCalE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6+Xt5MI0QrVrdqMqF96Cc9aZYBya4CXC/ut+UBSUqqkhmFOGEJeddFxUSz6EvgF6Q+eoEOF0fKUiw8VgSqDbigS6AlkUwKiKzSRtgQ8yy0JMALkqP0V+6Pbe9NJnMWw02/qT6Jn3cDhWWH4w2a2DAMhBkhD6DHtuqCROxpkUQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=oWf1L3hO; arc=none smtp.client-ip=80.12.242.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id bzgvtdAApg3tObzgytXhyU; Sun, 26 Jan 2025 11:16:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1737886598;
	bh=klF6L/kvlr7AzY5h2JLwWlbTwgiAx38bnUE1eQD8y0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=oWf1L3hOyhmguViw9TlgCexib621YO8MsoWFA5d/12RDveEu4eohh7T1nCDiIPqpQ
	 wLWlFW5/5IX+y5TA8SANruwDlUPjZyQbZZodLkpuZyDeI6GNPVhnXXEj0IvZlULLhr
	 k9Kqf6f6CTq7JPmct/4a/S7xeg999gxujO2KGKJWe2uGfXlHqSDuUXB5jtXf0yzeh3
	 8ziZ4qphgiSO08howBppvejjzDOM9PkdVOKQqVd2ela5e+hZ7huvkzorBPEspU9a6D
	 QxhcCRNZMQJwnuzV2oNEVbN3aWYNu7ugyxwQe5aH9eGf9xj8Izt7h8IyhZ9tcxwG73
	 NiC9ZMkWiP/Og==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 26 Jan 2025 11:16:38 +0100
X-ME-IP: 90.11.132.44
Message-ID: <f50e53b0-b880-40ef-8a35-d98f7b00eb35@wanadoo.fr>
Date: Sun, 26 Jan 2025 11:16:33 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/4] drivers/fpga/amd: Add new driver amd versal-pci
To: Yidong Zhang <yidong.zhang@amd.com>, linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org, mdf@kernel.org, hao.wu@intel.com,
 yilun.xu@intel.com
Cc: lizhi.hou@amd.com, DMG Karthik <Karthik.DMG@amd.com>,
 Nishad Saraf <nishads@amd.com>, Prapul Krishnamurthy <prapulk@amd.com>,
 Hayden Laccabue <hayden.laccabue@amd.com>
References: <20241210183734.30803-1-yidong.zhang@amd.com>
 <20241210183734.30803-2-yidong.zhang@amd.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241210183734.30803-2-yidong.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 10/12/2024 à 19:37, Yidong Zhang a écrit :
> AMD Versal based PCIe card, including V70, is designed for AI inference
> efficiency and is tuned for video analytics and natural language processing
> applications.

...

> +#define vdev_info(vdev, fmt, args...)					\
> +	dev_info(&(vdev)->pdev->dev, "%s: "fmt, __func__, ##args)
> +
> +#define vdev_warn(vdev, fmt, args...)					\
> +	dev_warn(&(vdev)->pdev->dev, "%s: "fmt, __func__, ##args)
> +
> +#define vdev_err(vdev, fmt, args...)					\
> +	dev_err(&(vdev)->pdev->dev, "%s: "fmt, __func__, ##args)
> +
> +#define vdev_dbg(vdev, fmt, args...)					\
> +	dev_dbg(&(vdev)->pdev->dev, fmt, ##args)

These helpers could also add the trailing \n.
It is apparently not added in the messages themselves.

CJ

