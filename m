Return-Path: <linux-fpga+bounces-1007-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1F5A1C742
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 11:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0AC1887AEC
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 10:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14CD433AD;
	Sun, 26 Jan 2025 10:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="YOZdF3B7"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-72.smtpout.orange.fr [80.12.242.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FCA2E40E;
	Sun, 26 Jan 2025 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737886380; cv=none; b=A9o5qgdPq2DDJfxtGtR2YqMuzYrAHBqD8TLA6e7hWbJ29weoFEr4BhPY5oOMS6OkroCDl/WNOK4IWVN7q30egQ6hBn25HVaHQBWawAkDNFJtMx+FpTF4xOeVsvLIfzmjOaDGU31WoACdOfZ2JdWsPCywDqWGsMqXi43tbw3mEEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737886380; c=relaxed/simple;
	bh=iPcEY7r52kvEYhDw4SYvmHBUaDJ1ZV1IlX2xEnaVdyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRvPhgsza44MlGm+sevC6DI53vcJKsaYj+gL5dRj7KC1QP0A/cor5opUSrC5J4Gi+sPbdLGSXV5lt382u9bU0A7lnPznNxm5QW++5tqiFAC4Cw5jEkjcPWn3e2Iz0lhZjo0Bn+jqUMtWvE029IQMPwmmV1uQJ80zCJK4/PZvWX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=YOZdF3B7; arc=none smtp.client-ip=80.12.242.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id bzdEtAGCY5GqKbzdItrD46; Sun, 26 Jan 2025 11:12:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1737886369;
	bh=6g/sgTgR0nXFvHVHGWs+nSkTA/crdrSOmdNaS+Bm+fU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=YOZdF3B72Bfk8/0NEFQ3gLh6KiECMI3CE5wxFfHFHibRAkMVUZvjoJp5sItZw0A3a
	 qIyAMmxYk1QWQr6gQM25JqYnQAt/atnJNqhtLJ4yg4hpbzXZg9KuKFVuM+1jWzew7q
	 Scuonwsmf/68mHKPiHU7EZcuaXSoo4OwjYNyFad9VJLXY9DJtT40cxBECgLWfendLJ
	 /hITzieW/lGUfzEbigCRRDDM5rd3iSlDr93fOko+Q1RDq9NilrrKydrEb5WSLq5fnQ
	 PJA2lXGcFcmwI551xI1LDIBrJX5YXVLbuhBHWpK1p/XN62Cr6ULb8c/WFtJZVLW2oN
	 yFhqTQPw9AKUg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 26 Jan 2025 11:12:49 +0100
X-ME-IP: 90.11.132.44
Message-ID: <d156bc11-3d8e-44a0-b311-b4b931c54a7c@wanadoo.fr>
Date: Sun, 26 Jan 2025 11:12:44 +0100
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

> +static void versal_pci_uuid_parse(struct versal_pci_device *vdev, uuid_t *uuid)
> +{
> +	char str[UUID_STRING_LEN];
> +	u8 i, j;
> +
> +	/* parse uuid into a valid uuid string format */
> +	for (i  = 0, j = 0; i < strlen(vdev->fw_id) && i < sizeof(str); i++) {

Unneeded extra space in "i  = 0"

I think that the compiler already does it on its own, but the strlen 
could be computed before the for loop.

> +		str[j++] = vdev->fw_id[i];
> +		if (j == 8 || j == 13 || j == 18 || j == 23)
> +			str[j++] = '-';
> +	}
> +
> +	uuid_parse(str, uuid);
> +	vdev_info(vdev, "Interface uuid %pU", uuid);
> +}
> +
> +static struct fpga_device *versal_pci_fpga_init(struct versal_pci_device *vdev)
> +{
> +	struct device *dev = &vdev->pdev->dev;
> +	struct fpga_manager_info info = { 0 };

Is the { 0 } needed?
Isn't the assigment below enough?

> +	struct fpga_device *fdev;
> +	int ret;
> +
> +	fdev = devm_kzalloc(dev, sizeof(*fdev), GFP_KERNEL);
> +	if (!fdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	fdev->vdev = vdev;
> +
> +	info = (struct fpga_manager_info) {
> +		.name = "AMD Versal FPGA Manager",
> +		.mops = &versal_pci_fpga_ops,
> +		.priv = fdev,
> +	};
> +
> +	fdev->mgr = fpga_mgr_register_full(dev, &info);
> +	if (IS_ERR(fdev->mgr)) {
> +		ret = PTR_ERR(fdev->mgr);
> +		vdev_err(vdev, "Failed to register FPGA manager, err %d", ret);
> +		return ERR_PTR(ret);
> +	}
> +
> +	/* Place holder for rm_queue_get_fw_id(vdev->rdev) */
> +	versal_pci_uuid_parse(vdev, &vdev->intf_uuid);
> +
> +	return fdev;
> +}

...

> +static struct firmware_device *versal_pci_fw_upload_init(struct versal_pci_device *vdev)
> +{
> +	struct device *dev = &vdev->pdev->dev;
> +	struct firmware_device *fwdev;
> +	u32 devid;
> +
> +	fwdev = devm_kzalloc(dev, sizeof(*fwdev), GFP_KERNEL);
> +	if (!fwdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	devid = versal_pci_devid(vdev);
> +	fwdev->name = kasprintf(GFP_KERNEL, "%s%x", DRV_NAME, devid);

Why is fwdev managed, and not fwdev->name?
It looks ok as-is, but using devm_kasprintf() would save a few lines of 
code.

> +	if (!fwdev->name)
> +		return ERR_PTR(-ENOMEM);
> +
> +	fwdev->fw = firmware_upload_register(THIS_MODULE, dev, fwdev->name,
> +					     &versal_pci_fw_ops, fwdev);
> +	if (IS_ERR(fwdev->fw)) {
> +		kfree(fwdev->name);
> +		return ERR_CAST(fwdev->fw);
> +	}
> +
> +	fwdev->vdev = vdev;
> +
> +	return fwdev;
> +}

...

> +static int versal_pci_probe(struct pci_dev *pdev, const struct pci_device_id *pdev_id)
> +{
> +	struct versal_pci_device *vdev;
> +	int ret;
> +
> +	vdev = devm_kzalloc(&pdev->dev, sizeof(*vdev), GFP_KERNEL);
> +	if (!vdev)
> +		return -ENOMEM;
> +
> +	pci_set_drvdata(pdev, vdev);
> +	vdev->pdev = pdev;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		vdev_err(vdev, "Failed to enable device %d", ret);
> +		return ret;
> +	}
> +
> +	vdev->io_regs = pcim_iomap_region(vdev->pdev, MGMT_BAR, DRV_NAME);
> +	if (IS_ERR(vdev->io_regs)) {
> +		vdev_err(vdev, "Failed to map RM shared memory BAR%d", MGMT_BAR);
> +		return PTR_ERR(vdev->io_regs);
> +	}
> +
> +	ret = versal_pci_device_setup(vdev);
> +	if (ret) {
> +		vdev_err(vdev, "Failed to setup Versal device %d", ret);
> +		return ret;
> +	}
> +
> +	vdev_dbg(vdev, "Successfully probed %s driver!", DRV_NAME);

Usually, such debug messages are not needed.
No strong opinion about it.

> +	return 0;
> +}

...

CJ

