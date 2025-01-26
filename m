Return-Path: <linux-fpga+bounces-1011-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D60A1C765
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 11:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BCC57A3756
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 10:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CD1524B0;
	Sun, 26 Jan 2025 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="MMkXxjBo"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-75.smtpout.orange.fr [80.12.242.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D47325A641;
	Sun, 26 Jan 2025 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737887653; cv=none; b=WjTfF7GbbHw219bWeCgHNl9vnv1+yqtASroXju0GA2RRv8Vl/bu4F9jRu+mJe1D9QDdbUJO9dONOw9l+mmBgdHKMnsOI4sUAovEltLe44iijyMLN4/e89gOe37m0Fx4dNDym8G2RxugYAPZWaI/Gt4Gv18dHutcgsjDIzyRmL1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737887653; c=relaxed/simple;
	bh=4Rb0QDK+DA9VlNt6JusdziNE8XZpWsCquKrZinDIDn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJ5hHZSPF62f6P+OoaB5IqS5CNvfHB+TXPALX8m95svceF4wT5ae7z+9e7w1ywYezn/ckxxIGIc2ka/h2P3hDTRCquLOunJUTwvmPC3scJi5t0gtNie/eoun7DP2skiVmWsDPDyCnvXNaiYiIZcYYo2Ay5SQLgFJA041JdH1a9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=MMkXxjBo; arc=none smtp.client-ip=80.12.242.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id bzp5tR0ZVFOEnbzp8t0fN2; Sun, 26 Jan 2025 11:25:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1737887103;
	bh=MhZiHQm2QlnS9YqD85Xidfq7NWkCrs99A2JNh9/mgVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=MMkXxjBoCTFGSCm/U8tV3fh/CcGbcYBT8Lenb9se5/H2DXAgDgbQCi3eUV9H1Ahwp
	 qJRdmHhxPufVm0quCZiTatMusYI1DV8p4cqEI7aYzSJig9Tm+fNpl3rgEUfkSpYZ5d
	 dXpiRreIEEcynkr8fxT0AZJTvudTbaw8lqMC+8uAxG7H11cQkhCiGQIj276razlrCA
	 Hv1kdjWumnvLYVq0U0QC/Th6oSEhhB9fSQFYIvyLu63BwHaUe4krlyBuxB9WT3RRNw
	 qL5+Udr8KRIywsPbLKMxjbFMKYNG9dndX/8lYRcDRhhtw5Co+XjZTyA8YuyD2VBkVc
	 bwokPkf/t5BFA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 26 Jan 2025 11:25:03 +0100
X-ME-IP: 90.11.132.44
Message-ID: <3d805a67-aae1-4342-90fd-c7d0dc100b3a@wanadoo.fr>
Date: Sun, 26 Jan 2025 11:24:58 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/4] drivers/fpga/amd: Add remote queue
To: Yidong Zhang <yidong.zhang@amd.com>, linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org, mdf@kernel.org, hao.wu@intel.com,
 yilun.xu@intel.com
Cc: lizhi.hou@amd.com, Nishad Saraf <nishads@amd.com>,
 Prapul Krishnamurthy <prapulk@amd.com>
References: <20241210183734.30803-1-yidong.zhang@amd.com>
 <20241210183734.30803-4-yidong.zhang@amd.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241210183734.30803-4-yidong.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 10/12/2024 à 19:37, Yidong Zhang a écrit :
> The remote queue is a hardware queue based ring buffer service between mgmt
> PF and PCIe hardware firmware for programming FPGA Program Logic, loading
> versal firmware and checking card healthy status.

...

> +static int rm_queue_submit_cmd(struct rm_cmd *cmd)
> +{
> +	struct versal_pci_device *vdev = cmd->rdev->vdev;
> +	struct rm_device *rdev = cmd->rdev;
> +	u32 offset;
> +	int ret;
> +
> +	mutex_lock(&rdev->queue);

Using guardmutex) would slightly simplify the code.

> +
> +	offset = rm_queue_get_sq_slot_offset(rdev);
> +	if (!offset) {
> +		vdev_err(vdev, "No SQ slot available");
> +		ret = -ENOSPC;
> +		goto exit;
> +	}
> +
> +	rm_queue_bulk_write(rdev, offset, (u32 *)&cmd->sq_msg,
> +			    sizeof(cmd->sq_msg));
> +
> +	ret = rm_queue_set_pidx(rdev, RM_QUEUE_SQ, ++rdev->sq.pidx);
> +	if (ret) {
> +		vdev_err(vdev, "Failed to update PIDX, ret %d", ret);
> +		goto exit;
> +	}
> +
> +	list_add_tail(&cmd->list, &rdev->submitted_cmds);
> +exit:
> +	mutex_unlock(&rdev->queue);
> +	return ret;
> +}
> +
> +void rm_queue_withdraw_cmd(struct rm_cmd *cmd)
> +{
> +	mutex_lock(&cmd->rdev->queue);

Using guardmutex) would slightly simplify the code.

> +	list_del(&cmd->list);
> +	mutex_unlock(&cmd->rdev->queue);
> +}

...

> +static void rm_check_msg(struct work_struct *w)
> +{
> +	struct rm_device *rdev = to_rdev_msg_monitor(w);
> +	int ret;
> +
> +	mutex_lock(&rdev->queue);

Using guardmutex) would slightly simplify the code.

> +
> +	rdev->sq.cidx = rm_queue_get_cidx(rdev, RM_QUEUE_SQ);
> +	rdev->cq.pidx = rm_queue_get_pidx(rdev, RM_QUEUE_CQ);
> +
> +	while (rdev->cq.cidx < rdev->cq.pidx) {
> +		ret = rm_process_msg(rdev);
> +		if (ret)
> +			break;
> +
> +		rdev->cq.cidx++;
> +
> +		rm_queue_set_cidx(rdev, RM_QUEUE_CQ, rdev->cq.cidx);
> +	}
> +
> +	mutex_unlock(&rdev->queue);
> +}

...

> +int rm_queue_init(struct rm_device *rdev)
> +{
> +	struct versal_pci_device *vdev = rdev->vdev;
> +	struct rm_queue_header header = {0};
> +	int ret;
> +
> +	INIT_LIST_HEAD(&rdev->submitted_cmds);
> +	mutex_init(&rdev->queue);

devm_mutex_init()?
In order to slightly simplify the code.

> +
> +	rm_queue_bulk_read(rdev, RM_HDR_OFF, (u32 *)&header, sizeof(header));
> +
> +	if (header.magic != RM_QUEUE_HDR_MAGIC_NUM) {
> +		vdev_err(vdev, "Invalid RM queue header");
> +		ret = -ENODEV;
> +		goto error;
> +	}

...

CJ

